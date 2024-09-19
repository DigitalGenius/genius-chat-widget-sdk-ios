import UIKit
import DGChatSDK
import SafariServices

/// This object is called to declare all `DGChatDelegate` methods in one place,
/// so it could be re-used all over this Demo app.
final class SDKDelegateObject: DGChatDelegate {
    
    weak var presenter: UIViewController?
    
    init(presenter: UIViewController? = nil) {
        self.presenter = presenter
        DGChat.delegate = self
    }
}

// MARK: DGChatDelegate

extension SDKDelegateObject {
    
    func didTrack(action: DGChatAction) {
        print("Action track:", action)
    }
    
    func didAttemptToOpen(url: URL) {
        let safari = SFSafariViewController(url: url)
        if let controller = self.presenter {
            controller.present(safari, animated: true)
        }
    }
    
    func didFailWith(error: Error) {
        print("😱 \(#function): \(error)")
    }
    
    var widgetId: String {
        fatalError("Place your widgetId here")
    }
    
    var env: String {
        fatalError("Place your environment here")
    }
    
    // Used for CRM integration, optional, line could be removed if not used
    var crmCredentials: DGChatCRMCredentials? {
        // .init(platform: "your CRM platform here", version: "your CRM Version here")
        nil
    }
    
    // User for additional metadata provided by Vendor
    var metadata: String {
        /*
        here is an example on how metadata should look like
        """
        metadata: {
            locale: 'en-gb',
            otherRandomData: 'abc123'
        }
        """
        */
        ""
    }
    
    var configs: [String : Any]? {
        /*
        here is an example on how configs should look like
        ["generalSettings": ["isChatLauncherEnabled": true]]
        */
        nil
    }
}
