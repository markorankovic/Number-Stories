final class GameTests: Hopes {
    
    func test_game_launch_success() {
        let game = Game()
        XCTAssert(game.stateMachine.currentState is LaunchedState)
    }
    
    func test_game_launch_failure() {
        let game = Game()
        game.stateMachine.enter(state: MainMenuState())
        XCTAssertFalse(game.stateMachine.currentState is LaunchedState)
    }
        
}
