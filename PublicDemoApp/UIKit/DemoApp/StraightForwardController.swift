import UIKit
import DGChatSDK

final class StraightForwardController: UIViewController {

    final var delegateObj = SDKDelegateObject()
    
    lazy final private var controlsView: ControlsView = {
        let view = ControlsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    final private lazy var resizeButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Resize", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(resizeAnimated), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var container: UIView?
    private var isHalfScreen: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        // Preloading content right after ViewController initialization to speed things up a bit.
        DGChat.prepare { view in
            print("DGChat seems ready enough!")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Present DGChatView right a way
        DGChat.added(to: self) { [weak self] chatView in
            print("DGChatView is presented now with frame \(chatView.frame)")
            self?.container = chatView
        }
    }
}

private extension StraightForwardController {
    
    func setupUI() {
        view.addSubview(controlsView)
        view.addSubview(resizeButton)
        let constraints = [
            controlsView.heightAnchor.constraint(lessThanOrEqualToConstant: 480),
            controlsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            controlsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            controlsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resizeButton.topAnchor.constraint(equalTo: controlsView.bottomAnchor, constant: 16),
            resizeButton.centerXAnchor.constraint(equalTo: controlsView.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        view.backgroundColor = .systemBackground
        
        let hideBarButton = UIBarButtonItem(title: "Hide Chat", style: .done, target: self, action: #selector(hideChatView))
        self.navigationItem.rightBarButtonItem = hideBarButton
    }
    
    @objc func hideChatView() {
        controlsView.hideWidget()
    }
    
    @objc func resizeAnimated() {
        container?.translatesAutoresizingMaskIntoConstraints = false
        isHalfScreen = isHalfScreen ? false : true
        let width = isHalfScreen ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width
        let height = isHalfScreen ? UIScreen.main.bounds.height / 2 : UIScreen.main.bounds.height
        container?.layer.borderColor = UIColor.red.cgColor
        container?.layer.borderWidth = isHalfScreen ? 1 : 0
        container?.constraints.forEach {
            container?.removeConstraint($0)
        }
        
        container?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        container?.widthAnchor.constraint(equalToConstant: isHalfScreen ? width : 0).isActive = true
        container?.heightAnchor.constraint(equalToConstant: isHalfScreen ? height : 0).isActive = true
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
            self?.container?.layoutIfNeeded()
        }
        
    }
}
