import Foundation
import UIKit

@available(iOS 13.0, *)
class NativeSafeAreaScrollView: UIScrollView {
    
    private var blurEffectView: UIVisualEffectView?
    private var showBlur: Bool = true
    private var topBlurHeightConstraint: NSLayoutConstraint?
    
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
        
        // Enable automatic content inset adjustment
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        
        // Set up content insets for safe area
        updateContentInsets()
        setupBlurEffect()
        
        // Listen for safe area changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateInsets),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    private func setupBlurEffect() {
        guard showBlur else { return }
        
        // Create blur effect for status bar area
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0.95
        blurView.isUserInteractionEnabled = false
        
        // Add blur to the scroll view's parent or self
        if let superview = self.superview {
            superview.insertSubview(blurView, aboveSubview: self)
            
            topBlurHeightConstraint = blurView.heightAnchor.constraint(equalToConstant: safeAreaInsets.top)
            
            NSLayoutConstraint.activate([
                blurView.topAnchor.constraint(equalTo: superview.topAnchor),
                blurView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                topBlurHeightConstraint!
            ])
        } else {
            // Fallback: add as subview
            addSubview(blurView)
            
            topBlurHeightConstraint = blurView.heightAnchor.constraint(equalToConstant: safeAreaInsets.top)
            
            NSLayoutConstraint.activate([
                blurView.topAnchor.constraint(equalTo: topAnchor),
                blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
                topBlurHeightConstraint!
            ])
        }
        
        blurEffectView = blurView
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Re-setup blur if needed when added to view hierarchy
        if superview != nil && showBlur && blurEffectView?.superview == nil {
            blurEffectView?.removeFromSuperview()
            blurEffectView = nil
            setupBlurEffect()
        }
    }
    
    private func updateContentInsets() {
        if #available(iOS 11.0, *) {
            let insets = safeAreaInsets
            contentInset = UIEdgeInsets(
                top: insets.top,
                left: insets.left,
                bottom: insets.bottom,
                right: insets.right
            )
            scrollIndicatorInsets = contentInset
        }
    }
    
    @objc private func updateInsets() {
        updateContentInsets()
        
        // Update blur effect height
        if let constraint = topBlurHeightConstraint {
            constraint.constant = safeAreaInsets.top
        }
        
        setNeedsLayout()
        layoutIfNeeded()
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
            topBlurHeightConstraint = nil
        }
    }
    
    func setScrollEnabled(_ enabled: Bool) {
        isScrollEnabled = enabled
    }
    
    func setShowsVerticalScrollIndicator(_ shows: Bool) {
        showsVerticalScrollIndicator = shows
    }
    
    func setShowsHorizontalScrollIndicator(_ shows: Bool) {
        showsHorizontalScrollIndicator = shows
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
