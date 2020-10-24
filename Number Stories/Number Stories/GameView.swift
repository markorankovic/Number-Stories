struct GameView: View {
    var game: Game
    let scene: GameScene
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
