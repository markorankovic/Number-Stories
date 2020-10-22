import SwiftUI
import SpriteKit

struct ContentView: View {
    @ObservedObject var game: Game
        
    var body: some View {
        if game.stateMachine.currentState is MainMenuState {
            MainMenuView(game: game)
        } else if game.stateMachine.currentState is PlayingState {
            GameView(game: game)
        } else {
            ProgressView()
        }
    }
}
