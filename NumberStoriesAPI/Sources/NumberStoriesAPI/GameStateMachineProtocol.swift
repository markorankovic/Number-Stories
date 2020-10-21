import SpriteKit

protocol GameStateMachineProtocol: StateMachineProtocol {
    func enter(state: GameState)
    func onEntry(from: GameState?)
    func onExit(to: GameState?)
    func onUpdate(currentTime: TimeInterval)
}
