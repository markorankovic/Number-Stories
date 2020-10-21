public class CutsceneState: GameState {
    
    override func onEntry(from: GameState?) {
        runCutscene()
    }
    
    private func runCutscene() {
        print("Running cutscene")
    }
    
}
