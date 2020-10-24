struct MainMenuView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        Text("Number Stories")
        Button("Play") {
            game.startLevel(level: Level())
            print("Play button")
        }
    }
}
