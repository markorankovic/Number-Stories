public class HandingRewardsState: GameState {
    
    override func onEntry(from: GameState?) {
        handoutRewards()
    }
    
    private func handoutRewards() {
        print("Handing out rewards")
    }

}

