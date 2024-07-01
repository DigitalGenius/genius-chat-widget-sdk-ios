import UIKit
import DGChatSDK

final class ControlsView: UIView {
    
    final private lazy var mesageButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Send test message", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(testMethods), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    final private lazy var expandButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Expand ChatView", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(expandWidget), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    final private lazy var hideChatButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Hide ChatView", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(hideWidget), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    final private lazy var stackView: UIStackView = {
        let subviews = [expandButton, hideChatButton, mesageButton]
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setup() {
        self.addSubview(stackView)
        let constraints = [
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

extension ControlsView {
    
    @objc func testMethods() {
        DGChat.sendMessage("This is TEST string") { result in
            do {
                try result.get()
            } catch {
                print("Failed to send message: \(error)")
            }
        }
    }
    
    @objc func expandWidget() {
        
        DGChat.expandWidget { result in
            switch result {
            case .success(let success):
                debugPrint(success)
            case .failure(let failure):
                debugPrint(failure)
                debugPrint("Widget should be initialized to call launch method")
            }
        }
    }
    
    @objc func hideWidget() {
        guard DGChat.isPresented else {
            print("Looks like ChatView is not presented yet...")
            return
        }
        DGChat.hide(animated: true) {
            print("ChatView must be hidden now")
        }
    }
}
