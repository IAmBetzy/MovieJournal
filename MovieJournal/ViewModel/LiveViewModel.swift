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

//Conectando el modelo con la vista de la camara
class LiveViewModel: NSObject, ObservableObject {
    //variable que obtiene las predicciones realizadas en la sesion
    @Published var actorQueue: [String] = []
    
    //Prediccion actualizada en tiempo real
    @Published var actorPrediction: String = "Aún no se observa ninguna persona."
    
    //Manda a llamar para recibir la configuracion inicial de la camara
    //was private
    let liveScreen = LiveScreen()
    
    override init() {
        super.init()
        liveScreen.delegate = self
        //Se inicia la captura de video.
        liveScreen.startSession()
    }
}

extension LiveViewModel: LiveScreenDelegate {
    
    //Se llama cada vez que la camara captura un frame nuevo.
    func didOutput(sampleBuffer: CMSampleBuffer) {
        //Convertir imagen a un pixelBuffer para ser procesado por el modelo.
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        //Para realizar las predicciones (De manera asincronica)
        DispatchQueue.global(qos: .userInitiated).async {
            guard let model = try? MovieActorClassifier2_5(configuration: MLModelConfiguration()) else { return }
            do {
                let prediction = try model.prediction(image: pixelBuffer)
                //Actualiza la prediccion constantemente.
                DispatchQueue.main.async {
                    //para cambiar la prediccion actual
                    self.actorPrediction = "Actor: \(prediction.target)"
                    //para guardar las predicciones hechas en la sesion, no se deben repetir
                    if !self.actorQueue.contains(prediction.target) {
                        self.actorQueue.insert(prediction.target, at: 0)
                    }
                    
                }
            } catch {
                DispatchQueue.main.async {
                    self.actorPrediction = "Prediction error: \(error.localizedDescription)"
                }
            }
        }
    }
}
