public struct Game: GameProtocol {
    public init() {}
    
    public var stateMachine = StateMachine(initialState: LaunchedState())
    
    func goToMainMenu() {
        print("Went to main menu.")
    }
    
    func presentTreats() {
        print("Presented treats")
    }
    
    func removeTreats() {
        print("Removed treats.")
    }
    
    func initiatePullFields() {
        print("Initiated pull fields.")
    }
    
    func initiateMarbleRepulsion() {
        print("Initiated marble repulsion.")
    }
    
    func startLevel(n: Int) {
        print("Started level \(n).")
    }
    
    func nextLevel() {
        print("Went to next level.")
    }
    
    func quit() {
        print("Quitted.")
    }
    
    func updateCounters() {
        print("Updated counters.")
    }
    
    func togglePause(on: Bool) {
        print("Toggled pause to \(on).")
    }
    
    func toggleSound(on: Bool) {
        print("Toggled sound to \(on).")
    }
    
    func toggleReward(on: Bool) {
        print("Toggled reward to \(on).")
    }
    
    func togglePhysics(on: Bool) {
        print("Toggled physics to \(on).")
    }
    
    
}
