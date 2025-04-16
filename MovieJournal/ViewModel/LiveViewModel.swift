//
//  LiveViewModel.swift
//  MovieJournal
//
//  Created by Claudia Moca on 15/04/25.
//

import Foundation
import AVFoundation
import SwiftUI
import CoreML

class LiveViewModel: NSObject, ObservableObject {
    @Published var actorPrediction: String = "Aún no se observa ninguna persona."
    
    //was private
    public let liveScreen = LiveScreen()
    
    override init() {
        super.init()
        liveScreen.delegate = self
        liveScreen.startSession()
    }
}

extension LiveViewModel: LiveScreenDelegate {
    func didOutput(sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        //para realizar las predicciones
        DispatchQueue.global(qos: .userInitiated).async {
            guard let model = try? MovieActorClassifier_6(configuration: MLModelConfiguration()) else { return }
            do {
                let prediction = try model.prediction(image: pixelBuffer)
                DispatchQueue.main.async {
                    self.actorPrediction = "Actor: \(prediction.target)"
                }
            } catch {
                DispatchQueue.main.async {
                    self.actorPrediction = "Prediction error: \(error.localizedDescription)"
                }
            }
        }
    }
}
