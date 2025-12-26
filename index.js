import { NativeModules, NativeEventEmitter } from 'react-native';

const LINKING_ERROR =
  `The package 'native-view-ios-26' doesn't seem to be linked. Make sure: \n\n` +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n' +
  '- If you are using Pods, run `pod install` in the ios folder\n';

const NativeViewIOS26Module = NativeModules.NativeViewIOS26
  ? NativeModules.NativeViewIOS26
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

const eventEmitter = new NativeEventEmitter(NativeViewIOS26Module);

const NativeViewIOS26 = {
  /**
   * Get the current safe area insets for the main window
   * @returns Promise resolving to safe area insets
   */
  getSafeAreaInsets() {
    return NativeViewIOS26Module.getSafeAreaInsets();
  },

  /**
   * Add listener for safe area changes
   * @param callback Function to call when safe area changes
   * @returns Subscription object with remove method
   */
  addSafeAreaListener(callback) {
    const subscription = eventEmitter.addListener(
      'onSafeAreaInsetsChange',
      callback
    );
    
    return {
      remove: () => {
        subscription.remove();
      },
    };
  },
};

export default NativeViewIOS26;

// Export components
export { NativeSafeAreaView, NativeSafeAreaScrollView } from './components';
