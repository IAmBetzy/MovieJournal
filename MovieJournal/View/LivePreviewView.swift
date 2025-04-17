
//
//  LivePreviewView.swift
//  MovieJournal
//
//  Created by Claudia Moca on 15/04/25.
//

//UIView representable ya que SwiftUI no tiene soporte directo para AVCaptureSession
import SwiftUI
import AVFoundation

struct LivePreviewView: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        //Muestra el video
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
