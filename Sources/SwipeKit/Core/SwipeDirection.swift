import Foundation

/// The direction of a swipe action.
public enum SwipeDirection: Sendable {
    /// Swiped toward the left side of the screen.
    case left
    /// Swiped toward the right side of the screen.
    case right
    /// Swiped toward the top of the screen.
    case up
    /// Swiped toward the bottom of the screen.
    case down
}
