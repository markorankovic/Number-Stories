public class StateMachine: StateMachineProtocol {
    public private(set) var currentState: GameState = UnknownState() {
        didSet {
            currentState.onEntry(from: oldValue)
            print("State transitions from \(oldValue) to \(currentState)")
        }
        willSet {
            currentState.onExit(to: newValue)
            print("State transitions from \(currentState) to \(newValue)")
        }
    }
    
    init(initialState: GameState) {
        enter(state: initialState)
    }
    
    public func enter(state: GameState) {
        currentState = state
    }
}
