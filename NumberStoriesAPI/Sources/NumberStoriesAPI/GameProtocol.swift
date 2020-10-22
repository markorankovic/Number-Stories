protocol GameProtocol {
    func goToMainMenu()
    func presentTreats()
    func removeTreats()
    
    func initiatePullFields()
    func initiateMarbleRepulsion()
    
    func startLevel(level: Level)
    func nextLevel()
    func quit()
    
    func updateCounters()
    
    func togglePause(on: Bool)
    func toggleSound(on: Bool)
    func toggleReward(on: Bool)
    func togglePhysics(on: Bool)
}
