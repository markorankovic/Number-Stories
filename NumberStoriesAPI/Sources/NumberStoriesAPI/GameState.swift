public class GameState: GameStateProtocol {
    
    var stateMachine: StateMachine?
    
    public init() { }
    
    public convenience init(stateMachine: StateMachine) {
        self.init()
        self.stateMachine = stateMachine
    }
    
    func enter(state: GameState) {
        
    }
    func onEntry(from: GameState?) {
        
    }
    func onExit(to: GameState?) {
        
    }
}
