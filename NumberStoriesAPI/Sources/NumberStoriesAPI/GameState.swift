public enum GameState: Equatable {
    case launched
    case mainMenu
    case loading
    case playing(PlayingState)
}

public enum PlayingState {
    case paused
    case userInteraction
    case cutscene
    case handingRewards
}
