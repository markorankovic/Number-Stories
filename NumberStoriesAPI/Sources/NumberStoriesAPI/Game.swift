import SwiftUI
public class Game: ObservableObject, GameProtocol {
    
    public init() { }
    
    @ObservedObject public var stateMachine = StateMachine(initialState: LaunchedState()) {
        willSet {
            print(20)
        }
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
        stateMachine.enter(state: PlayingState(stateMachine: stateMachine))
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
