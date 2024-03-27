import UIKit
import DGChatSDK

final class ManualCallController: UIViewController {
    
    final var delegateObj = SDKDelegateObject()
    
    lazy final private var controlsView: ControlsView = {
        let view = ControlsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    final private lazy var startButton: LoadyButton = {
        let button = LoadyButton(type: .roundedRect)
        button.setTitle("Show ChatView", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(showChatView), for: .touchUpInside)
        button.indicatorColor = .gray
        return button
    }()
    
    final private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startButton, controlsView])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension ManualCallController {
    
    func setupUI() {
        view.addSubview(stackView)
        let constraints = [
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ]
        NSLayoutConstraint.activate(constraints)
        view.backgroundColor = .systemBackground
        
        let hideBarButton = UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(hideChatView))
        let minimiseBarButton = UIBarButtonItem(title: "Minimise", style: .done, target: self, action: #selector(minimiseChat))
        self.navigationItem.rightBarButtonItems = [minimiseBarButton, hideBarButton]
    }
}

extension ManualCallController {
    
    @objc private func showChatView() {
        // Check if ChatView is not presented yet.
        // This check is optional, just for Demo purpose. Actual check is also being done inside SDK as well.
        if DGChat.isPresented {
            print("Looks like ChatView is already presented")
            return
        }
        // Start animating button's spinner
        startButton.setSpinner(shown: true)
        // Present ChatView overlay
        DGChat.added(to: self) { [weak self] chatView in
            print("ChatView shown with frame \(chatView.frame)")
            self?.startButton.setSpinner(shown: false)
        }
    }
    
    @objc private func hideChatView() {
        controlsView.hideWidget()
    }
    
    @objc private func minimiseChat() {
        DGChat.minimizeWidget { _ in
            
        }
    }
}
