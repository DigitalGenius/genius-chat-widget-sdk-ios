import UIKit
import DGChatSDK

final class StraightForwardController: UIViewController {

    final var delegateObj = SDKDelegateObject()
    
    lazy final private var controlsView: ControlsView = {
        let view = ControlsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.addSubview(controlsView)
        let constraints = [
            controlsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            controlsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            controlsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
        ]
        NSLayoutConstraint.activate(constraints)
        view.backgroundColor = .systemBackground
        
        let hideBarButton = UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(hideChatView))
        let minimiseBarButton = UIBarButtonItem(title: "Minimise", style: .done, target: self, action: #selector(minimiseChat))
        self.navigationItem.rightBarButtonItems = [minimiseBarButton, hideBarButton]
    }
    
    @objc func hideChatView() {
        controlsView.hideWidget()
    }
    
    @objc private func minimiseChat() {
        DGChat.minimizeWidget { _ in
            
        }
    }
}
