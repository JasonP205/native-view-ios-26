import React from 'react';
import { requireNativeComponent } from 'react-native';

// Native View Component
const RNNativeSafeAreaView = requireNativeComponent('NativeSafeAreaView');

export const NativeSafeAreaView = ({ 
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
const RNNativeSafeAreaScrollView = requireNativeComponent('NativeSafeAreaScrollView');

export const NativeSafeAreaScrollView = ({ 
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
