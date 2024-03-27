import SwiftUI
import DGChatSDK

struct ContentView: View {
    
    var body: some View {
        VStack {
            GeniusChatView(
                widgetId: "\(fatalError("Place your widged id here"))",
                env: "\(fatalError("Place your widged id here"))",
                scriptVersion: "\(fatalError("script version is required"))",
                // .init(platform: "your CRM platform here", version: "your CRM version here")
                crmCredenrials: nil, // optional, line could be removed if not used
                onChatAction: { action in
                    print("Chat action", action)
                })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
