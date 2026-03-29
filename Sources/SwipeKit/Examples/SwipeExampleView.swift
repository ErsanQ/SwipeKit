import SwiftUI
import SwipeKit

struct User: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let age: Int
    let imageUrl: String
}

struct SwipeExampleView: View {
    @State private var users: [User] = [
        User(name: "Sarah", age: 24, imageUrl: "person.fill"),
        User(name: "John", age: 28, imageUrl: "person.2.fill"),
        User(name: "Emma", age: 22, imageUrl: "person.3.fill"),
        User(name: "David", age: 31, imageUrl: "person.crop.circle.fill"),
        User(name: "Olivia", age: 26, imageUrl: "star.fill")
    ]
    
    @State private var lastAction: String = "Swipe to start"
    
    var body: some View {
        VStack(spacing: 30) {
            Text("SwipeKit Demo")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(lastAction)
                .font(.headline)
                .foregroundColor(.secondary)
            
            CardStack(items: $users) { user in
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                        
                        Image(systemName: user.imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(60)
                            .foregroundColor(.white)
                    }
                    .frame(width: 300, height: 400)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(user.name), \(user.age)")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("iOS Developer @ErsanQ")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 10)
            } onSwipe: { user, direction in
                print("Swiped \(user.name) to \(direction)")
                lastAction = "Swiped \(user.name) \(direction.rawValue)"
                
                // Remove the top card
                if !users.isEmpty {
                    users.removeLast()
                }
            }
            
            HStack(spacing: 40) {
                ActionButton(icon: "xmark", color: .red) {
                    // Logic for manual trigger left as exercise
                    lastAction = "Disliked"
                }
                ActionButton(icon: "heart.fill", color: .green) {
                    lastAction = "Liked"
                }
            }
            
            if users.isEmpty {
                Button("Reset Deck") {
                    users = [
                        User(name: "Sarah", age: 24, imageUrl: "person.fill"),
                        User(name: "John", age: 28, imageUrl: "person.2.fill")
                    ]
                }
            }
        }
    }
}

struct ActionButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .padding()
                .background(Circle().stroke(color, lineWidth: 2))
        }
    }
}

#Preview {
    SwipeExampleView()
}
