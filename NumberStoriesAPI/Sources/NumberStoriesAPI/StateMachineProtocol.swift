protocol StateMachineProtocol {
    func enter(state: GameState)
    func onEntry(from: GameState?)
    func onExit(to: GameState?)
}
