# Example: Using native-view-ios-26 in React Native App

## Quick Start

```javascript
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import NativeViewIOS26 from 'native-view-ios-26';

export default function SafeAreaExample() {
  const [insets, setInsets] = useState({ top: 0, bottom: 0, left: 0, right: 0 });

  useEffect(() => {
    // Get initial insets
    NativeViewIOS26.getSafeAreaInsets().then(setInsets);

    // Listen for changes
    const subscription = NativeViewIOS26.addSafeAreaListener(setInsets);

    return () => subscription.remove();
  }, []);

  return (
    <View style={styles.container}>
      <View style={[styles.content, {
        paddingTop: insets.top,
        paddingBottom: insets.bottom,
        paddingLeft: insets.left,
        paddingRight: insets.right,
      }]}>
        <Text style={styles.title}>Safe Area Insets</Text>
        <Text style={styles.text}>Top: {insets.top}px</Text>
        <Text style={styles.text}>Bottom: {insets.bottom}px</Text>
        <Text style={styles.text}>Left: {insets.left}px</Text>
        <Text style={styles.text}>Right: {insets.right}px</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f0f0f0',
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  text: {
    fontSize: 18,
    marginVertical: 5,
  },
});
```

## Advanced Usage

### Custom Hook

```javascript
import { useEffect, useState } from 'react';
import NativeViewIOS26 from 'native-view-ios-26';

export function useSafeAreaInsets() {
  const [insets, setInsets] = useState({
    top: 0,
    bottom: 0,
    left: 0,
    right: 0,
  });

  useEffect(() => {
    NativeViewIOS26.getSafeAreaInsets().then(setInsets);
    
    const subscription = NativeViewIOS26.addSafeAreaListener(setInsets);
    
    return () => subscription.remove();
  }, []);

  return insets;
}

// Usage
function MyComponent() {
  const insets = useSafeAreaInsets();
  
  return (
    <View style={{ paddingTop: insets.top }}>
      {/* Your content */}
    </View>
  );
}
```
