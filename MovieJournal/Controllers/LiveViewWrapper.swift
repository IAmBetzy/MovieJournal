//
//  LiveViewModel.swift
//  MovieJournal
//
//  Created by Claudia Moca on 15/04/25.
//

import SwiftUI

//Not used

struct LiveViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LiveViewController {
        return LiveViewController()
    }

    func updateUIViewController(_ uiViewController: LiveViewController, context: Context) {
    }
}
