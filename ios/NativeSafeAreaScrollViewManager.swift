import Foundation
import UIKit
import React

@objc(NativeSafeAreaScrollViewManager)
class NativeSafeAreaScrollViewManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeSafeAreaScrollView()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func setShowBlur(_ view: NativeSafeAreaScrollView, showBlur: Bool) {
        view.setShowBlur(showBlur)
    }
    
    @objc func setScrollEnabled(_ view: NativeSafeAreaScrollView, scrollEnabled: Bool) {
        view.setScrollEnabled(scrollEnabled)
    }
    
    @objc func setShowsVerticalScrollIndicator(_ view: NativeSafeAreaScrollView, shows: Bool) {
        view.setShowsVerticalScrollIndicator(shows)
    }
    
    @objc func setShowsHorizontalScrollIndicator(_ view: NativeSafeAreaScrollView, shows: Bool) {
        view.setShowsHorizontalScrollIndicator(shows)
    }
}
