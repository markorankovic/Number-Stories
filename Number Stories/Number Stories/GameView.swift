struct GameView: View {
    var game: Game
    let scene = GameScene(fileNamed: "GameScene.sks")!
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
