import UIKit
import DGChatSDK

final class ViewController: UIViewController {
    
    final private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "List of Examples on how to use an SDK. Tap that buttons to check."
        return label
    }()
    
    final private lazy var straightForwardButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Straight-forward example", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(showStraightForwardController), for: .touchUpInside)
        return button
    }()
    
    final private lazy var manualExampleButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Manual SDK presentation example", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(showManualCallController), for: .touchUpInside)
        return button
    }()
    
    final private lazy var customAnimationButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Custom animation example", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(showCustomAnimationController), for: .touchUpInside)
        return button
    }()
    
    final private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textLabel, manualExampleButton, straightForwardButton, customAnimationButton])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setup() {
        view.addSubview(stackView)
        let constraints = [
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ]
        NSLayoutConstraint.activate(constraints)
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ViewController {
    
    @objc private func showStraightForwardController() {
        self.navigationController?.pushViewController(StraightForwardController(), animated: true)
    }
    
    @objc private func showManualCallController() {
        self.navigationController?.pushViewController(ManualCallController(), animated: true)
    }
    
    @objc private func showCustomAnimationController() {
        self.navigationController?.pushViewController(CustomAnimationController(), animated: true)
    }
}
