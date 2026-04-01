[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FErsanQ%2FSwipeKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ErsanQ/SwipeKit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FErsanQ%2FSwipeKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/ErsanQ/SwipeKit)
# SwipeKit

A smooth, Tinder-style card swipe library for SwiftUI. Swipe right to like, left to dislike, and more—with zero boilerplate.

![SwipeKit Demo](Resources/demo.png)

## Features
- **Zero Boilerplate**: Add swipe gestures with `.onSwipe { ... }`.
- **CardStack Component**: Manage stacks of cards with automatic depth and rotation.
- **Fluid Animations**: Spring-based movements for a natural, native feel.
- **Customizable**: Handle swipes in any direction (left, right, top, bottom).

## Supported Platforms
- iOS 14.0+
- macOS 11.0+

## Installation

```swift
.package(url: "https://github.com/ErsanQ/SwipeKit", from: "1.0.0")
```

## Usage

### Simple Swipe Modifier
```swift
Image("Profile")
    .onSwipe { direction in
        if direction == .right {
            print("Liked!")
        }
    }
```

### Using CardStack
```swift
CardStack(items: $users) { user in
    UserCard(user: user)
} onSwipe: { user, direction in
    print("Swiped \(user.name) to \(direction)")
    // Logic to remove from array
}
```

## Author
ErsanQ (Swift Package Index Community)
