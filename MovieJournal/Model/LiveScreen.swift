//
//  LiveScreen.swift
//  MovieJournal
//
//  Created by Claudia Moca on 15/04/25.
//

import AVFoundation

protocol LiveScreenDelegate: AnyObject {
    func didOutput(sampleBuffer: CMSampleBuffer)
}

class LiveScreen: NSObject {
    //was private
    public let session = AVCaptureSession()
    private let output = AVCaptureVideoDataOutput()
    weak var delegate: LiveScreenDelegate?
    
    var pivotPinchScale: CGFloat = 1
    private var drawings: [CAShapeLayer] = []
    
    var previewLayer: AVCaptureVideoPreviewLayer {
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        return preview
    }
    
    func startSession() {
        guard let device = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: device) else { return }
        
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

extension LiveScreen: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.didOutput(sampleBuffer: sampleBuffer)
    }
}
