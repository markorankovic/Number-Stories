public class UserInteractionState: GameState {
    
    override func onEntry(from: GameState?) {
        unlockUserInteraction()
    }
    
    private func unlockUserInteraction() {
        print("User interaction unlocked.")
    }

}
