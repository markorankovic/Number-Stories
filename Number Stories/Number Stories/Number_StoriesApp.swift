@main
struct Number_StoriesApp: App {
    var game = Game()
    let scene = GameScene()
    var body: some Scene {
        WindowGroup {
            ContentView(game: game, gameView: GameView(game: game, scene: scene))
        }
    }
    init() {
        game.enter(state: MainMenuState(game: game))
        scene.game = game
    }
}
