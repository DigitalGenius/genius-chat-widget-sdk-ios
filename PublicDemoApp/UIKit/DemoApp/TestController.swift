import UIKit
import DGChatSDK

final class TestController: UIViewController {
    
    final private lazy var expandButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Expand Widget", for: .normal)
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
        let subviews = [expandButton, hideChatButton]
        let stackView = UIStackView(arrangedSubviews: subviews)
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

private extension TestController {
    
    func setupUI() {
        view.addSubview(stackView)
        let constraints = [
            stackView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        view.backgroundColor = .systemBackground
    }
}

extension TestController {
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
