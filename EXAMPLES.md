# Ví dụ sử dụng native-view-ios-26

## 1. Basic Usage - NativeSafeAreaView

```javascript
import React from 'react';
import { Text, StyleSheet } from 'react-native';
import { NativeSafeAreaView } from 'native-view-ios-26';

export default function BasicExample() {
  return (
    <NativeSafeAreaView style={styles.container}>
      <Text style={styles.text}>Hello from Safe Area!</Text>
      <Text style={styles.text}>Blur effect tự động dưới status bar</Text>
    </NativeSafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    fontSize: 18,
    marginVertical: 10,
  },
});
```

## 2. ScrollView với Blur Effect

```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { NativeSafeAreaScrollView } from 'native-view-ios-26';

export default function ScrollViewExample() {
  return (
    <NativeSafeAreaScrollView 
      style={styles.container}
      showBlur={true}
      showsVerticalScrollIndicator={true}
    >
      <View style={styles.header}>
        <Text style={styles.title}>My Article</Text>
      </View>
      
      {Array.from({ length: 50 }).map((_, i) => (
        <View key={i} style={styles.item}>
          <Text>Item {i + 1}</Text>
        </View>
      ))}
    </NativeSafeAreaScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    padding: 20,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
  },
  item: {
    padding: 20,
    backgroundColor: '#fff',
    marginVertical: 5,
    marginHorizontal: 10,
    borderRadius: 8,
  },
});
```

## 3. Tùy chỉnh Blur Effect

```javascript
import React, { useState } from 'react';
import { View, Text, Switch, StyleSheet } from 'react-native';
import { NativeSafeAreaView } from 'native-view-ios-26';

export default function CustomBlurExample() {
  const [blurEnabled, setBlurEnabled] = useState(true);

  return (
    <NativeSafeAreaView style={styles.container} showBlur={blurEnabled}>
      <View style={styles.content}>
        <Text style={styles.title}>Blur Effect Control</Text>
        
        <View style={styles.control}>
          <Text>Enable Blur Effect</Text>
          <Switch 
            value={blurEnabled} 
            onValueChange={setBlurEnabled} 
          />
        </View>
      </View>
    </NativeSafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  content: {
    flex: 1,
    padding: 20,
    justifyContent: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 30,
    textAlign: 'center',
  },
  control: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 15,
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
  },
});
```

## 4. Kết hợp với Safe Area Insets API

```javascript
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import NativeViewIOS26, { NativeSafeAreaView } from 'native-view-ios-26';

export default function CombinedExample() {
  const [insets, setInsets] = useState({ top: 0, bottom: 0, left: 0, right: 0 });

  useEffect(() => {
    // Lấy safe area insets
    NativeViewIOS26.getSafeAreaInsets().then(setInsets);

    // Lắng nghe thay đổi
    const subscription = NativeViewIOS26.addSafeAreaListener(setInsets);

    return () => subscription.remove();
  }, []);

  return (
    <NativeSafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.title}>Safe Area Info</Text>
        
        <View style={styles.infoBox}>
          <Text style={styles.label}>Top:</Text>
          <Text style={styles.value}>{insets.top}px</Text>
        </View>
        
        <View style={styles.infoBox}>
          <Text style={styles.label}>Bottom:</Text>
          <Text style={styles.value}>{insets.bottom}px</Text>
        </View>
        
        <View style={styles.infoBox}>
          <Text style={styles.label}>Left:</Text>
          <Text style={styles.value}>{insets.left}px</Text>
        </View>
        
        <View style={styles.infoBox}>
          <Text style={styles.label}>Right:</Text>
          <Text style={styles.value}>{insets.right}px</Text>
        </View>
      </View>
    </NativeSafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  content: {
    flex: 1,
    padding: 20,
    justifyContent: 'center',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 30,
    textAlign: 'center',
  },
  infoBox: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 15,
    backgroundColor: '#f0f0f0',
    marginVertical: 5,
    borderRadius: 8,
  },
  label: {
    fontSize: 18,
    fontWeight: '600',
  },
  value: {
    fontSize: 18,
    color: '#007AFF',
  },
});
```

## 5. Custom Hook cho Safe Area

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

// Sử dụng
function MyComponent() {
  const insets = useSafeAreaInsets();
  
  return (
    <View style={{ paddingTop: insets.top }}>
      <Text>Custom padding với safe area</Text>
    </View>
  );
}
```

## 6. Full Screen App Example

```javascript
import React from 'react';
import { View, Text, Image, TouchableOpacity, StyleSheet } from 'react-native';
import { NativeSafeAreaScrollView } from 'native-view-ios-26';

export default function FullScreenApp() {
  return (
    <NativeSafeAreaScrollView 
      style={styles.container}
      showBlur={true}
    >
      {/* Hero Image */}
      <Image 
        source={{ uri: 'https://picsum.photos/400/300' }}
        style={styles.heroImage}
      />
      
      {/* Content */}
      <View style={styles.content}>
        <Text style={styles.title}>Welcome to My App</Text>
        <Text style={styles.subtitle}>
          Blur effect tự động dưới status bar, 
          không bị che khuất nội dung
        </Text>
        
        <TouchableOpacity style={styles.button}>
          <Text style={styles.buttonText}>Get Started</Text>
        </TouchableOpacity>
        
        {/* Features */}
        <View style={styles.features}>
          {['Feature 1', 'Feature 2', 'Feature 3'].map((feature, i) => (
            <View key={i} style={styles.featureCard}>
              <Text style={styles.featureTitle}>{feature}</Text>
              <Text style={styles.featureDesc}>
                Description for {feature}
              </Text>
            </View>
          ))}
        </View>
      </View>
    </NativeSafeAreaScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  heroImage: {
    width: '100%',
    height: 300,
  },
  content: {
    padding: 20,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 20,
    lineHeight: 24,
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 30,
  },
  buttonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: '600',
  },
  features: {
    gap: 15,
  },
  featureCard: {
    padding: 20,
    backgroundColor: '#f5f5f5',
    borderRadius: 12,
  },
  featureTitle: {
    fontSize: 20,
    fontWeight: '600',
    marginBottom: 8,
  },
  featureDesc: {
    fontSize: 14,
    color: '#666',
  },
});
```
