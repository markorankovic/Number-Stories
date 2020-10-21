public class MainMenuState: GameState {
    
    override func onEntry(from: GameState?) {
        returnToMainMenu()
    }
    
    private func returnToMainMenu() {
        print("Returned to main menu.")
    }

}
