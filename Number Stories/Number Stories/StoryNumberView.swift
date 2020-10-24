import SwiftUI

struct StoryNumberView: View {
    let storyNumber: Int
    var body: some View {
        Text("\(storyNumber)")
    }
}

struct StoryNumberView_Previews: PreviewProvider {
    static var previews: some View {
        StoryNumberView(storyNumber: 10)
    }
}
