public class GameState: GameStateProtocol {
    
    var game: Game?
    
    public init() { }
    
    public convenience init(game: Game) {
        self.init()
        self.game = game
    }
    
    func enter(state: GameState) {
        
    }
    func onEntry(from: GameState?) {
        
    }
    func onExit(to: GameState?) {
        
    }
    public func touchesMoved(_ touches: Set<UITouch>, _ scene: SKScene) {
        
    }
    
    public func onUpdate(timeInterval: TimeInterval, scene: SKScene) {
        
    }
    
}
