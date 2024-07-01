import UIKit
import DGChatSDK

final class NavigationCallController: UIViewController {
    
    final var delegateObj = SDKDelegateObject()
    
    final private lazy var startButton: LoadyButton = {
        let button = LoadyButton(type: .roundedRect)
        button.setTitle("Show on NavigationController", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(showChatView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.indicatorColor = .gray
        return button
    }()
    
    final private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startButton])
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
    
    @objc private func showChatView() {
        // Start animating button's spinner
        startButton.setSpinner(shown: true)
        // Check if UINavigationController is present
        guard let nav = self.navigationController else { 
            return
        }
        // Present ChatView overlay
        DGChat.added(to: nav) { [weak self] chatView in
            // Hide spinner
            self?.startButton.setSpinner(shown: false)
            // Push ViewController to Navigation Stack
            self?.navigationController?.pushViewController(ChildViewController(), animated: true)
        }
    }
    
    @objc private func hideChatView() {
        ControlsView().hideWidget()
    }
}
