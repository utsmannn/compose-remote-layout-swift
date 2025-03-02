# Compose Remote Layout Swift

This is Swift Wrapper for [compose-remote-layout](https://github.com/utsmannn/compose-remote-layout) without Kotlin setup.

## Installation
Add ComposeRemoteLayoutSwift to your project using the Swift Package Manager:

1. Open your Xcode project.
2. Go to File > Swift Packages > Add Package Dependency…
3. Enter the repository URL for ComposeRemoteLayoutSwift.
4. Follow the prompts to complete the setup.

## Setup
### Simple setup
```swift
import ComposeRemoteLayoutSwift
import SwiftUI

struct ContentView: View {
    private let bindValue: BindsValue = BindsValue()
    @State private var jsonLayout: String = """
    {
      "column": {
        "children": [
          {
            "text": {
              "content": "Hello from Remote Layout"
            }
          }
        ]
      }
    }
    """
    
    var body: some View {
        DynamicLayoutView(
            jsonLayout: $jsonLayout,
            bindsValue: bindValue
        )
    }
}

```

### Add custom SwiftUI
```swift
import ComposeRemoteLayoutSwift
import SwiftUI

@main
struct MyApp: App {
    // add delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
    
        // Register custom SwiftUI
        CustomNodes.register(type: "banner") { data in
            // getValue from
            let title = data["title"] ?? "Default Title"
            return Text(title)
        }
        
        return true
    }
}

```
