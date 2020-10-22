@main
struct Number_StoriesApp: App {
    var game = Game()
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
    init() {
        game.stateMachine.enter(state: MainMenuState(stateMachine: game.stateMachine))
    }
}
