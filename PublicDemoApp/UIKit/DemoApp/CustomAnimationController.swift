import UIKit
import DGChatSDK

final class CustomAnimationController: UIViewController {
    
    final var delegateObj = SDKDelegateObject()
    
    final private lazy var toggle = ToggleView(frame: .zero)
    
    final private lazy var visibilityButton: LoadyButton = {
        let button = LoadyButton(type: .roundedRect)
        button.setTitle("Show/Hide ChatView", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(toggleChatViewVisiblity), for: .touchUpInside)
        button.indicatorColor = .gray
        return button
    }()
 
    final private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toggle, visibilityButton])
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

private extension CustomAnimationController {
    
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
    }
}


extension CustomAnimationController {
    
    @objc private func toggleChatViewVisiblity() {
        // Start animating button's spinner
        visibilityButton.setSpinner(shown: true)
        // Check if we must use a custom animation
        if toggle.useCustomAnimation {
            // Present ChatView overlay
            DGChat.prepare { [weak self] overlay in
                // Capture self pointer
                guard let this = self else { return }
                
                // Stop spinner
                this.visibilityButton.setSpinner(shown: false)
            }
        } else {
            self.visibilityButton.setSpinner(shown: true)
        }
    }
}
