import React from 'react';
import { requireNativeComponent, ViewProps, ViewStyle } from 'react-native';

// Native View Component
interface NativeSafeAreaViewProps extends ViewProps {
  showBlur?: boolean;
  style?: ViewStyle;
}

const RNNativeSafeAreaView = requireNativeComponent<NativeSafeAreaViewProps>('NativeSafeAreaView');

export const NativeSafeAreaView: React.FC<NativeSafeAreaViewProps> = ({ 
  showBlur = true,
  children,
  style,
  ...props
}) => {
  return (
    <RNNativeSafeAreaView showBlur={showBlur} style={style} {...props}>
      {children}
    </RNNativeSafeAreaView>
  );
};

// Native ScrollView Component
interface NativeSafeAreaScrollViewProps extends ViewProps {
  showBlur?: boolean;
  scrollEnabled?: boolean;
  showsVerticalScrollIndicator?: boolean;
  showsHorizontalScrollIndicator?: boolean;
  style?: ViewStyle;
}

const RNNativeSafeAreaScrollView = requireNativeComponent<NativeSafeAreaScrollViewProps>('NativeSafeAreaScrollView');

export const NativeSafeAreaScrollView: React.FC<NativeSafeAreaScrollViewProps> = ({ 
  showBlur = true,
  scrollEnabled = true,
  showsVerticalScrollIndicator = true,
  showsHorizontalScrollIndicator = false,
  children,
  style,
  ...props
}) => {
  return (
    <RNNativeSafeAreaScrollView 
      showBlur={showBlur}
      scrollEnabled={scrollEnabled}
      showsVerticalScrollIndicator={showsVerticalScrollIndicator}
      showsHorizontalScrollIndicator={showsHorizontalScrollIndicator}
      style={style}
      {...props}
    >
      {children}
    </RNNativeSafeAreaScrollView>
  );
};
