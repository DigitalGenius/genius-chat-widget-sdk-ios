import UIKit
import DGChatSDK

final class ChildViewController: UIViewController {
    
    final private lazy var pushButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Navigate further", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(navigateFurther), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    final private lazy var stackView: UIStackView = {
        let subviews = [pushButton]
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

private extension ChildViewController {
    
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
        
        let hideBarButton = UIBarButtonItem(title: "Hide Chat",
                                            style: .done,
                                            target: self,
                                            action: #selector(hideChatView))
        self.navigationItem.rightBarButtonItems = [hideBarButton]
    }
}

extension ChildViewController {
    
    @objc func navigateFurther() {
        self.navigationController?.pushViewController(ChildViewController(), animated: true)
    }
    
    @objc private func hideChatView() {
        ControlsView().hideWidget()
    }
}
