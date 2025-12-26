import Foundation
import UIKit

@available(iOS 13.0, *)
class NativeSafeAreaView: UIView {
    
    private var blurEffectView: UIVisualEffectView?
    private var contentView: UIView!
    private var showBlur: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        // Create content view
        contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        setupBlurEffect()
        updateConstraints()
        
        // Listen for safe area changes
        if #available(iOS 11.0, *) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(updateInsets),
                name: UIDevice.orientationDidChangeNotification,
                object: nil
            )
        }
    }
    
    private func setupBlurEffect() {
        guard showBlur else { return }
        
        // Create blur effect for status bar area
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0.95
        
        insertSubview(blurView, at: 0)
        blurEffectView = blurView
        
        // Pin blur to top
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.heightAnchor.constraint(equalToConstant: safeAreaInsets.top)
        ])
    }
    
    private func updateConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func updateInsets() {
        setNeedsLayout()
        layoutIfNeeded()
        
        // Update blur effect height
        if let blurView = blurEffectView {
            blurView.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.constant = safeAreaInsets.top
                }
            }
        }
    }
    
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        updateInsets()
    }
    
    func setShowBlur(_ show: Bool) {
        guard showBlur != show else { return }
        showBlur = show
        
        if show {
            setupBlurEffect()
        } else {
            blurEffectView?.removeFromSuperview()
            blurEffectView = nil
        }
    }
    
    // Override to add subviews to contentView instead
    override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
        contentView.insertSubview(subview, at: atIndex)
    }
    
    override func removeReactSubview(_ subview: UIView!) {
        subview.removeFromSuperview()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
