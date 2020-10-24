import SwiftUI
import SpriteKit

struct ContentView: View {
    @ObservedObject var game: Game
    let gameView: GameView
        
    var body: some View {
        if game.currentState is MainMenuState {
            MainMenuView(game: game)
        } else if let _ = game.currentState as? PlayingState {
            gameView
        } else {
            ProgressView()
        }
    }
}
