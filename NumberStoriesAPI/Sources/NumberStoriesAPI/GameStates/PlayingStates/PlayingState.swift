public class PlayingState: GameState {
    
    override func onEntry(from previousState: GameState?) {
        if previousState is MainMenuState, var stateMachine = stateMachine {
            stateMachine.enter(state: UserInteractionState(stateMachine: stateMachine))
        }
    }
    
}
