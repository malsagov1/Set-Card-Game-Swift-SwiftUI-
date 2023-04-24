//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Умар Мальсагов on 13.08.2021.
//

import SwiftUI

@main
struct SetGame_App: App {
    private let game = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGame_View(game: game)
        }
    }
}
