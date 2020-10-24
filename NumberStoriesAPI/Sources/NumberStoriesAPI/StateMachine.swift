public class StateMachine: StateMachineProtocol {
    private(set) var currentState: GameState = UnknownState() {
        didSet {
            currentState.onEntry(from: oldValue)
        }
        willSet {
            currentState.onExit(to: newValue)
            print("State transitions from \(currentState) to \(newValue)")
        }
    }
    
    init(initialState: GameState) {
        enter(state: initialState)
    }
    
    func enter(state: GameState) {
        currentState = state
    }
}
