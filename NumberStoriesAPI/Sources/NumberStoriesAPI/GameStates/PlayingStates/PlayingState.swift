public class PlayingState: GameState {
    
    override func onEntry(from previousState: GameState?) {
        if previousState is MainMenuState, let stateMachine = stateMachine {
            stateMachine.enter(state: UserInteractionState(stateMachine: stateMachine))
        }
    }
    
}
