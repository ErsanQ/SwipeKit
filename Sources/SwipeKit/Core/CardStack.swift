#if canImport(SwiftUI)
import SwiftUI

/// A Tinder-style card stack component for fluid swipe interactions.
///
/// `CardStack` manages a collection of identifiable data and renders them as
/// an interactive deck. Users can swipe cards left or right to trigger actions.
///
/// ## Usage
/// ```swift
/// CardStack(users) { user, direction in
///     print("Swiped \(user.name) to the \(direction)")
/// } content: { user in
///     UserCardView(user: user)
/// }
/// ```
@MainActor
public struct CardStack<Data: Identifiable, Content: View>: View {
    private let data: [Data]
    private let content: (Data) -> Content
    private let onSwipe: (Data, SwipeDirection) -> Void
    
    /// Creates a new CardStack.
    ///
    /// - Parameters:
    ///   - data: The array of items to display in the stack.
    ///   - onSwipe: A closure called when a card is swiped past the threshold.
    ///   - content: A view builder that defines the appearance of each card.
    public init(_ data: [Data], onSwipe: @escaping (Data, SwipeDirection) -> Void, @ViewBuilder content: @escaping (Data) -> Content) {
        self.data = data
        self.onSwipe = onSwipe
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            ForEach(data.reversed()) { item in
                CardView(item: item, onSwipe: onSwipe) {
                    content(item)
                }
            }
        }
    }
}

/// An internal view that handles the individual drag gesture and animation for a single card.
@MainActor
private struct CardView<Data: Identifiable, Content: View>: View {
    let item: Data
    let onSwipe: (Data, SwipeDirection) -> Void
    let content: Content
    
    @State private var offset: CGSize = .zero
    
    init(item: Data, onSwipe: @escaping (Data, SwipeDirection) -> Void, @ViewBuilder content: () -> Content) {
        self.item = item
        self.onSwipe = onSwipe
        self.content = content()
    }
    
    var body: some View {
        content
            .offset(offset)
            .rotationEffect(.degrees(Double(offset.width / 20)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            let direction: SwipeDirection = offset.width > 0 ? .right : .left
                            onSwipe(item, direction)
                        } else {
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                    }
            )
    }
}
#endif
