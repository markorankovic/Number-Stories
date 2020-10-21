final class GameTests: Hopes {
    
    func test_game_launch_success() {
        let game = Game()
        hope(game.gameState) == .launched
    }
    
    func test_game_launch_failure() {
        var game = Game()
        game.gameState = .mainMenu
        hope(game.gameState) != .launched
    }
    
}
