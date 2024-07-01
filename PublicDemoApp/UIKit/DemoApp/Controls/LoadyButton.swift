import UIKit

open class LoadyButton: UIButton {

    public var indicatorColor: UIColor = .white

    open var originalButtonText: String?
    open var activityIndicator: UIActivityIndicatorView!
    open var originalImage: UIImage?

    public func setSpinner(shown: Bool) {
        if shown { showLoading() } else { hideLoading() }
    }

    public func showLoading() {
        originalButtonText = titleLabel?.text
        setTitle("", for: .normal)
        originalImage = image(for: .normal)
        setImage(nil, for: .normal)
        createActivityIndicatorIfNeeded()
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
        isUserInteractionEnabled = false
    }

    public func hideLoading() {
        if let t = originalButtonText {
            setTitle(t, for: .normal)
        }
        if let oi = originalImage {
            setImage(oi, for: .normal)
        }
        activityIndicator?.stopAnimating()
        isUserInteractionEnabled = true
    }

    private func createActivityIndicatorIfNeeded() {
        if self.activityIndicator == nil {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            self.activityIndicator = activityIndicator
            addSubview(activityIndicator)
            centerActivityIndicatorInButton()
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = indicatorColor
    }

    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
