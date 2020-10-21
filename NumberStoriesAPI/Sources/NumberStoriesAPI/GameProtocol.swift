protocol GameProtocol {
    func goToMainMenu()
    func presentTreats()
    func removeTreats()
    
    func initiatePullFields()
    func initiateMarbleRepulsion()
    
    func startLevel(n: Int)
    func nextLevel()
    func quit()
    
    func updateCounters()
    
    func togglePause(on: Bool)
    func toggleSound(on: Bool)
    func toggleReward(on: Bool)
    func togglePhysics(on: Bool)
}
