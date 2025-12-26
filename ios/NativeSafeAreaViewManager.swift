import Foundation
import UIKit
import React

@objc(NativeSafeAreaViewManager)
class NativeSafeAreaViewManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeSafeAreaView()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
