#if canImport(SwiftUI)
import SwiftUI

public extension View {
    /// Adds Tinder-style swipe gestures to a view.
    /// - Parameters:
    ///   - threshold: The distance required to trigger a swipe action.
    ///   - onSwipe: A closure to execute when a swipe direction is determined.
    /// - Returns: A swipable view.
    func onSwipe(threshold: CGFloat = 120, onSwipe: @escaping (SwipeDirection) -> Void) -> some View {
        self.modifier(SwipeModifier(threshold: threshold, onSwipe: onSwipe))
    }
}

private struct SwipeModifier: ViewModifier {
    let threshold: CGFloat
    let onSwipe: (SwipeDirection) -> Void
    
    @State private var offset: CGSize = .zero
    @State private var isRemoved = false
    
    func body(content: Content) -> some View {
        content
            .offset(offset)
            .rotationEffect(.degrees(Double(offset.width / 20)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        handleSwipeEnd()
                    }
            )
            .opacity(isRemoved ? 0 : 1)
            .animation(.spring(), value: offset)
    }
    
    private func handleSwipeEnd() {
        if offset.width > threshold {
            triggerSwipe(.right)
        } else if offset.width < -threshold {
            triggerSwipe(.left)
        } else if offset.height < -threshold {
            triggerSwipe(.up)
        } else if offset.height > threshold {
            triggerSwipe(.down)
        } else {
            // Snap back
            offset = .zero
        }
    }
    
    private func triggerSwipe(_ direction: SwipeDirection) {
        let width: CGFloat = direction == .right ? 500 : (direction == .left ? -500 : 0)
        let height: CGFloat = direction == .down ? 500 : (direction == .up ? -500 : 0)
        
        withAnimation(.easeOut(duration: 0.3)) {
            offset = CGSize(width: width, height: height)
            isRemoved = true
        }
        
        // Notify after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onSwipe(direction)
        }
    }
}
#endif
