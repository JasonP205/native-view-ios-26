import * as React from 'react';
import { ViewProps, ViewStyle } from 'react-native';

export interface SafeAreaInsets {
  top: number;
  bottom: number;
  left: number;
  right: number;
}

export interface NativeViewIOS26 {
  /**
   * Get the current safe area insets for the main window
   * @returns Promise resolving to safe area insets
   */
  getSafeAreaInsets(): Promise<SafeAreaInsets>;
  
  /**
   * Add listener for safe area changes
   * @param callback Function to call when safe area changes
   * @returns Subscription object with remove method
   */
  addSafeAreaListener(callback: (insets: SafeAreaInsets) => void): {
    remove: () => void;
  };
}

declare const NativeViewIOS26: NativeViewIOS26;

export default NativeViewIOS26;

// Native Components Props
export interface NativeSafeAreaViewProps extends ViewProps {
  /**
   * Whether to show blur effect under status bar
   * @default true
   */
  showBlur?: boolean;
  style?: ViewStyle;
  children?: React.ReactNode;
}

export interface NativeSafeAreaScrollViewProps extends ViewProps {
  /**
   * Whether to show blur effect under status bar
   * @default true
   */
  showBlur?: boolean;
  /**
   * Whether scrolling is enabled
   * @default true
   */
  scrollEnabled?: boolean;
  /**
   * Whether to show vertical scroll indicator
   * @default true
   */
  showsVerticalScrollIndicator?: boolean;
  /**
   * Whether to show horizontal scroll indicator
   * @default false
   */
  showsHorizontalScrollIndicator?: boolean;
  style?: ViewStyle;
  children?: React.ReactNode;
}

// Component exports
export const NativeSafeAreaView: React.FC<NativeSafeAreaViewProps>;
export const NativeSafeAreaScrollView: React.FC<NativeSafeAreaScrollViewProps>;

