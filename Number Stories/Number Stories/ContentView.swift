import SwiftUI
import SpriteKit

struct ContentView: View {
    let scene = GameScene(fileNamed: "GameScene.sks")!
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
