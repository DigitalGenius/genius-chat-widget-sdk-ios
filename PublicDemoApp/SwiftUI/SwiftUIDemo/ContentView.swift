import SwiftUI
import DGChatSDK

struct ContentView: View {
    
    /// Sample configs
    private let configs = ["generalSettings": ["isChatLauncherEnabled": false]]
    
    var body: some View {
        VStack {
            GeniusChatView(
                widgetId: "\(fatalError("Place your widged id here"))",
                env: "\(fatalError("Place your widged id here"))",
                configs: ["generalSettings": ["isChatLauncherEnabled": false]]
                // .init(platform: "your CRM platform here", version: "your CRM version here")
            )
            .padding()
            Button("Chat with us", action: {
                DGChat.expandWidget({ result in
                    // Handle the method action result here
                })
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
