import UIKit

final class ToggleView: UIView {
    
    var useCustomAnimation: Bool {
        animationToggle.isOn
    }
    
    private var observer: NSKeyValueObservation?
    
    final private lazy var animationToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        return toggle
    }()
    
    final private lazy var toggleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Use custom animation"
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()
    
    final private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toggleTitleLabel, animationToggle])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
