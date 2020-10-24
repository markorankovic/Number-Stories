import SwiftUI
public class Game: ObservableObject, GameProtocol {
    
    public init() { }
    
    public let stateMachine = StateMachine(initialState: LaunchedState())
    
    public var currentState: GameState {
        stateMachine.currentState
    }
    
    public func enter(state: GameState) {
        stateMachine.enter(state: state)
        objectWillChange.send()
    }
    
    func goToMainMenu() {
        stateMachine.enter(state: MainMenuState())
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
    
    public func startLevel(level: Level) {
        enter(state: PlayingState(game: self))
        print("Started level \(level).")
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
