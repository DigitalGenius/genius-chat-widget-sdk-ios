import UIKit
import DGChatSDK

final class NavigationCallController: UIViewController {
    
    final var delegateObj = SDKDelegateObject()
    
    lazy final private var controlsView: ControlsView = {
        let view = ControlsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    final private lazy var startButton: LoadyButton = {
        let button = LoadyButton(type: .roundedRect)
        button.setTitle("Show ChatView over Navigation Controller", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(showChatView), for: .touchUpInside)
        button.indicatorColor = .gray
        return button
    }()
    
    final private lazy var pushButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Push controller for test", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(pushTestController), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    final private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startButton, pushButton, controlsView])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension NavigationCallController {
    
    func setupUI() {
        view.addSubview(stackView)
        let constraints = [
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        view.backgroundColor = .systemBackground
        
        let hideBarButton = UIBarButtonItem(title: "Hide Chat", style: .done, target: self, action: #selector(hideChatView))
        self.navigationItem.rightBarButtonItem = hideBarButton
    }
}

extension NavigationCallController {
    
    @objc private func pushTestController() {
        let vc = TestController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
        guard let nav = self.navigationController else {
            print("Looks like there is no Navigation Controller or this ViewController isn't rootViewController of your NavigationController")
            return
        }
        DGChat.added(to: nav) { [weak self] chatView in
            print("ChatView shown with frame \(chatView.frame)")
            self?.startButton.setSpinner(shown: false)
        }
    }
    
    @objc private func hideChatView() {
        controlsView.hideWidget()
    }
}
