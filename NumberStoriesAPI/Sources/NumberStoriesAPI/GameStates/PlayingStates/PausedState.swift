public class PausedState: GameState {
    
    override func onEntry(from: GameState?) {
        pauseGame()
    }
    
    private func pauseGame() {
        print("Game paused.")
    }

}
