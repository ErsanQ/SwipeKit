import SwiftUI

/// A component that renders a stack of swipable cards.
public struct CardStack<T: Identifiable & Equatable, Content: View>: View {
    @Binding var items: [T]
    let content: (T) -> Content
    let onSwipe: (T, SwipeDirection) -> Void
    
    public init(
        items: Binding<[T]>,
        @ViewBuilder content: @escaping (T) -> Content,
        onSwipe: @escaping (T, SwipeDirection) -> Void
    ) {
        self._items = items
        self.content = content
        self.onSwipe = onSwipe
    }
    
    public var body: some View {
        ZStack {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                if index >= items.count - 3 { // Only show top 3 cards for performance
                    content(item)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .padding(.top, CGFloat((items.count - 1 - index) * 10))
                        .scaleEffect(1 - CGFloat((items.count - 1 - index) * 0.05))
                        .zIndex(Double(index))
                        // Apply swipe ONLY to the top card
                        .modifier(SwipeEnabler(isEnabled: index == items.count - 1) { direction in
                            onSwipe(item, direction)
                            // Note: Implementation for removing item is left to user or handled here
                        })
                }
            }
        }
    }
}

private struct SwipeEnabler: ViewModifier {
    let isEnabled: Bool
    let onSwipePerformed: (SwipeDirection) -> Void
    
    func body(content: Content) -> some View {
        if isEnabled {
            content.onSwipe(onSwipe: onSwipePerformed)
        } else {
            content
        }
    }
}
