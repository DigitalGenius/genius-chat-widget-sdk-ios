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
            let animationDuration = TimeInterval(0.5)
            // Present ChatView overlay
            DGChat.prepare { [weak self] overlay in
                // Capture self pointer
                guard let this = self, let overlay else { return }
                
                // Stop spinner
                this.visibilityButton.setSpinner(shown: false)

                let hiddenStateTransform = CGAffineTransform(
                    translationX: 0,
                    y: (this.view.window?.windowScene?.screen.bounds.height ?? 0)
                )
                
                if !DGChat.isPresented { // Show
                    overlay.alpha = 0.0
                    if overlay.superview == nil {
                        this.view.addSubview(overlay)
                    }
                    overlay.frame = this.view.bounds
                    overlay.transform = hiddenStateTransform
                    overlay.alpha = 1.0
                    UIView.animate(withDuration: animationDuration) {
                        overlay.transform = .identity
                    }
                } else { // Hide
                    UIView.animate(withDuration: animationDuration, animations: {
                        overlay.transform = hiddenStateTransform
                    }, completion: { done in
                        if done { overlay.alpha = 0.0 }
                    })
                }
            }
        } else {
            self.visibilityButton.setSpinner(shown: true)
            // Hiding overlay if it was already presented
            if DGChat.isPresented {
                DGChat.hide { [weak self] in
                    self?.visibilityButton.setSpinner(shown: false)
                }
            } else {
                // Presenting overlay with default animation
                DGChat.added(to: self) { [weak self] _ in
                    self?.visibilityButton.setSpinner(shown: false)
                }
            }
        }
    }
}
