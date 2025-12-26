import Foundation
import UIKit
import React

@objc(NativeViewIOS26)
class NativeViewIOS26: RCTEventEmitter {
    
    private var hasListeners = false
    private var observers: [NSObjectProtocol] = []
    
    override init() {
        super.init()
        setupObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: - RCTEventEmitter
    
    override func supportedEvents() -> [String]! {
        return ["onSafeAreaInsetsChange"]
    }
    
    override func startObserving() {
        hasListeners = true
    }
    
    override func stopObserving() {
        hasListeners = false
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    // MARK: - Setup Observers
    
    private func setupObservers() {
        let notificationNames: [NSNotification.Name] = [
            UIDevice.orientationDidChangeNotification,
            UIApplication.didBecomeActiveNotification
        ]
        
        for name in notificationNames {
            let observer = NotificationCenter.default.addObserver(
                forName: name,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.notifySafeAreaChange()
            }
            observers.append(observer)
        }
    }
    
    private func removeObservers() {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        observers.removeAll()
    }
    
    // MARK: - Public Methods
    
    @objc
    func getSafeAreaInsets(
        _ resolve: @escaping RCTPromiseResolveBlock,
        rejecter reject: @escaping RCTPromiseRejectBlock
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                reject("ERROR", "Module deallocated", nil)
                return
            }
            
            if let insets = self.getCurrentSafeAreaInsets() {
                resolve(insets)
            } else {
                reject("ERROR", "Failed to get safe area insets", nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func getCurrentSafeAreaInsets() -> [String: CGFloat]? {
        guard let window = getKeyWindow() else {
            return nil
        }
        
        let safeAreaInsets = window.safeAreaInsets
        
        return [
            "top": safeAreaInsets.top,
            "bottom": safeAreaInsets.bottom,
            "left": safeAreaInsets.left,
            "right": safeAreaInsets.right
        ]
    }
    
    private func getKeyWindow() -> UIWindow? {
        // iOS 13+ compatible way to get key window
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    private func notifySafeAreaChange() {
        guard hasListeners else { return }
        
        if let insets = getCurrentSafeAreaInsets() {
            sendEvent(withName: "onSafeAreaInsetsChange", body: insets)
        }
    }
}
