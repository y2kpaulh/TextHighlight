//
//  TextHighlightApp.swift
//  TextHighlight
//
//  Created by Inpyo Hong on 2022/10/20.
//

import SwiftUI

@main
struct TextHighlightApp: App {
    @StateObject private var viewModel = ContentViewModel(verseList: [
        "The Lord is my shepherd, I lack nothing.",
        "He makes me lie down in green pastures,he leads me beside quiet waters,",
        "he refreshes my soul. He guides me along the right paths for his name’s sake.",
        "Even though I walk through the darkest valley, I will fear no evil,for you are with me; your rod and your staff, they comfort me.",
        "You prepare a table before me in the presence of my enemies. You anoint my head with oil; my cup overflows.",
        "Surely your goodness and love will follow me all the days of my life, and I will dwell in the house of the Lord forever."
    ])

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
