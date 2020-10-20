import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        SpriteView(scene: GameScene(size: .zero))
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
