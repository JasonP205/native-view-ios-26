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
}
