public class PlayingState: GameState {
    
    override func onEntry(from previousState: GameState?) {
        if previousState is MainMenuState, let game = game {
            print(game.stateMachine.currentState)
            game.enter(state: UserInteractionState(game: game))
        }
    }
    
    func nodes(scene: SKScene) -> [DraggableNode] {
        return scene.children.compactMap{ $0 as? DraggableNode }
    }
        
}
