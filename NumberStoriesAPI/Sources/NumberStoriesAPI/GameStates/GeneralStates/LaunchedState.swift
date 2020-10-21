public class LaunchedState: GameState {
    
    override func onEntry(from: GameState?) {
        launchGame()
    }
    
    private func launchGame() {
        print("Game launched.")
    }

}
