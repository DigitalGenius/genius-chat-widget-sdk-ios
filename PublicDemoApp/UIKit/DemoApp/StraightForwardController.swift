import UIKit
import DGChatSDK

final class StraightForwardController: UIViewController {

    final var delegateObj = SDKDelegateObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        // Preloading content right after ViewController initialization to speed things up a bit.
        DGChat.prepare { view in
            print("DGChat seems ready enough!")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Present DGChatView right a way
        DGChat.added(to: self) { chatView in
            print("DGChatView is presented now with frame \(chatView.frame)")
        }
    }
}

private extension StraightForwardController {
    
    func setupUI() {
        let hideBarButton = UIBarButtonItem(title: "Hide Chat", 
                                            style: .done,
                                            target: self,
                                            action: #selector(hideChatView))
        self.navigationItem.rightBarButtonItem = hideBarButton
    }
    
    @objc func hideChatView() {
        ControlsView().hideWidget()
    }
}
