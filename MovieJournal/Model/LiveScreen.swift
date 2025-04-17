//
//  LiveScreen.swift
//  MovieJournal
//
//  Created by Claudia Moca on 15/04/25.
//

import AVFoundation

//Protocolo
protocol LiveScreenDelegate: AnyObject {
    func didOutput(sampleBuffer: CMSampleBuffer)
}

class LiveScreen: NSObject {
    //Session controla tanto el input como el output del video
    //was private
    public let session = AVCaptureSession()
    //Los frames capturados por la camara que seran procesados por el modelo
    private let output = AVCaptureVideoDataOutput()
    weak var delegate: LiveScreenDelegate?
    
    var previewLayer: AVCaptureVideoPreviewLayer {
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        return preview
    }
    
    func startSession() {
        guard let device = AVCaptureDevice.default(for: .video),
                //Comienza a tomar el video del liveScreen
                let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        session.beginConfiguration()
        session.sessionPreset = .high
        
        if session.canAddInput(input) { session.addInput(input) }
        if session.canAddOutput(output) { session.addOutput(output) }
        
        let queue = DispatchQueue(label: "camera.queue")
        output.setSampleBufferDelegate(self, queue: queue)
        output.alwaysDiscardsLateVideoFrames = true
        
        session.commitConfiguration()
        session.startRunning()
    }
}

//En este caso lo que activa el delegate es cada vez que cambia el frame del video
extension LiveScreen: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //Los frames (output) se mandan al liveViewModel para que este los procese con el modelo y de un resultado.
        delegate?.didOutput(sampleBuffer: sampleBuffer)
    }
}
