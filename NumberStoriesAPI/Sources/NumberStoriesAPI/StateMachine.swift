public class StateMachine: StateMachineProtocol {
    public private(set) var currentState: GameState = UnknownState() {
        didSet {
            currentState.onEntry(from: oldValue)
            print("State transitions from \(oldValue) to \(currentState)")
        }
    }
    
    init(initialState: GameState) {
        enter(state: initialState)
    }
    
    public func enter(state: GameState) {
        currentState = state
    }
}
