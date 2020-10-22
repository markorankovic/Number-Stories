struct MainMenuView: View {
    @ObservedObject var game: Game {
        willSet {
            print(10)
        }
    }
    var body: some View {
        Text("Number Stories")
        Button("Play") {
            game.startLevel(level: Level())
        }
    }
}
