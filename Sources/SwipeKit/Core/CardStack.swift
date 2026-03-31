import SwiftUI

/// A stack of cards that can be swiped in different directions.
@MainActor
public struct CardStack<Data: Identifiable, Content: View>: View {
    private let data: [Data]
    private let content: (Data) -> Content
    private let onSwipe: (Data, SwipeDirection) -> Void
    
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
