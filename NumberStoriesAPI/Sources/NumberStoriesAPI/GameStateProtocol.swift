protocol GameStateProtocol {
    func onEntry(from: GameStateProtocol?)
    func onExit(to: GameStateProtocol?)
}
