protocol GameStateProtocol {
    func onEntry(from: GameState?)
    func onExit(to: GameState?)
}
