//
//  LiveViewController.swift
//  MovieJournal
//
//  Created by Claudia Moca on 15/04/25.
//

import UIKit
import AVFoundation
import Vision

class LiveViewController: UIViewController{
    let photoOutput = AVCapturePhotoOutput()
    let videoOutput = AVCaptureVideoDataOutput()
    private var movieOutput: AVCaptureMovieFileOutput?
    
    //representa un dispositivo de captura (camara)
    var captureDevice : AVCaptureDevice? = nil
    //instancia de AVCaptureSession
    let captureSession =  AVCaptureSession()
    //Hace el display de lo que ve la camara
    var previewLayer : AVCaptureVideoPreviewLayer?
    //se utilizara para la funcion de zoom. Pinching with fingers
    var pivotPinchScale: CGFloat = 1
    private var drawings: [CAShapeLayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //revisa si hay una camara disponnible. Si no, utiliza la camara de atras. Si no, utiliza la camara de enfrente. Si no, sale un error ya que es necesario que exista alguna camara.
        if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
            captureDevice = device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            captureDevice = device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        } else {
            fatalError("Missing expected back camera device.")
        }
        //configuracion de la camara ya que se encuentra un dispositivo de camara
        if let captureDevice = captureDevice {
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            do {
                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                
                if captureSession.canAddOutput(photoOutput) {
                    captureSession.addOutput(photoOutput)
                }
            }
            catch {
                print("error: \(error.localizedDescription)")
            }
            //con el preview layer el usuario podra ver la camara en vivo
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.frame = UIScreen.main.bounds
            previewLayer?.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(previewLayer!)
            captureSession.commitConfiguration()
            //El pinch gesture ayuda al usuario a hacer zoom in y zoom out
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchToZoom(_:)))
            self.view.addGestureRecognizer(pinchGestureRecognizer)
        }
        if let audioDevice = AVCaptureDevice.default(for: .audio) {
            do {
                let audioInput = try AVCaptureDeviceInput(device: audioDevice)
                if captureSession.canAddInput(audioInput) {
                    captureSession.addInput(audioInput)
                }
            } catch {
                print("Error setting up audio input: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func pinchToZoom(_ gesture: UIPinchGestureRecognizer) {
            if let device = captureDevice {
                do {
                    try device.lockForConfiguration()
                    switch gesture.state {
                    case .began:
                        self.pivotPinchScale = device.videoZoomFactor
                    case .changed:
                        var factor = self.pivotPinchScale * gesture.scale
                        factor = max(1, min(factor, device.activeFormat.videoMaxZoomFactor))
                        device.videoZoomFactor = factor
                    default:
                        break
                    }
                    device.unlockForConfiguration()
                } catch {
                    // handle exception
                }
            }
        }
    
    //para comenzar a capturar los datos
    override func viewWillAppear(_ animated: Bool) {
        getCameraFrames()
        captureSession.startRunning()
    }
    //para detener la sesion correctamente
    override func viewDidDisappear(_ animated: Bool) {
        captureSession.stopRunning()
        movieOutput?.stopRecording()
    }
    
    //configuracion de los video frames. Formato de pixel, orientacion del video, etc.
    private func getCameraFrames() {
        videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        if !captureSession.outputs.contains(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        guard let connection = videoOutput.connection(with: .video), connection.isVideoOrientationSupported else {
            return
        }
        connection.videoOrientation = .portrait
    }
    
    //esta funcion elimina los cuadros verdes que fueron dibujados anteriormente
    private func clearDrawings() {
        for drawing in drawings {
            drawing.removeFromSuperlayer()
        }
        drawings.removeAll()
    }
    
    //esta funcion inicializa la deteccion de caras
    private func detectFace(image: CVPixelBuffer) {
        let faceDetectionRequest = VNDetectFaceLandmarksRequest { vnRequest, error in
            DispatchQueue.main.async {
                if let results = vnRequest.results as? [VNFaceObservation], results.count > 0 {
                    self.handleFaceDetectionResults(observedFaces: results, pixelBuffer: image)
                }
            }
        }
        let imageResultHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageResultHandler.perform([faceDetectionRequest])
    }
    //esta funcion dibuja los cuadros en la pantalla
    private func handleFaceDetectionResults(observedFaces: [VNFaceObservation], pixelBuffer: CVPixelBuffer) {
        
        clearDrawings()
        
        guard let previewLayer = previewLayer else {
            return
        }
        for faceObservation in observedFaces {
            let faceBoundingBoxOnScreen = previewLayer.layerRectConverted(fromMetadataOutputRect: faceObservation.boundingBox)
            let faceBoundingBoxPath = CGPath(rect: faceBoundingBoxOnScreen, transform: nil)
            let faceBoundingBoxShape = CAShapeLayer()
            
            faceBoundingBoxShape.strokeColor = UIColor.green.cgColor
            faceBoundingBoxShape.path = faceBoundingBoxPath
            faceBoundingBoxShape.fillColor = UIColor.clear.cgColor
            view.layer.addSublayer(faceBoundingBoxShape)
            drawings.append(faceBoundingBoxShape)
        }
    }
}

//busca la informacion de cada frame y despues lo manda a detectFace para mas procesamiento o analisis.
extension LiveViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        detectFace(image: frame)
    }
}
