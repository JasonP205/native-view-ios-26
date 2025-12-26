# Hướng dẫn cài đặt và sử dụng native-view-ios-26

## 📦 Bước 1: Cài đặt thư viện

### Nếu đang phát triển thư viện này (local):

```bash
# Trong dự án React Native của bạn
cd YourReactNativeApp

# Link thư viện local
npm install /Users/jasonphan/Documents/NodeLibs/native-view-ios-26

# Hoặc dùng yarn
yarn add file:/Users/jasonphan/Documents/NodeLibs/native-view-ios-26
```

### Nếu publish lên npm:

```bash
npm install native-view-ios-26
# hoặc
yarn add native-view-ios-26
```

## 📱 Bước 2: Cài đặt iOS dependencies

```bash
cd ios
pod install
cd ..
```

## 🔧 Bước 3: Rebuild app

```bash
# Xóa build cũ
rm -rf ios/build

# Rebuild app
npx react-native run-ios
```

## ✅ Bước 4: Sử dụng trong code

### Cách 1: Sử dụng Components với Blur Effect

```typescript
import React from 'react';
import { Text, StyleSheet } from 'react-native';
import { NativeSafeAreaView } from 'native-view-ios-26';

export default function App() {
  return (
    <NativeSafeAreaView style={styles.container}>
      <Text style={styles.text}>Hello iOS 26!</Text>
      <Text style={styles.text}>Blur effect dưới status bar</Text>
    </NativeSafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    fontSize: 20,
    marginVertical: 10,
  },
});
```

### Cách 2: Sử dụng ScrollView

```typescript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { NativeSafeAreaScrollView } from 'native-view-ios-26';

export default function ScrollApp() {
  return (
    <NativeSafeAreaScrollView style={styles.container}>
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
  item: {
    padding: 20,
    backgroundColor: '#fff',
    marginVertical: 5,
    marginHorizontal: 10,
    borderRadius: 8,
  },
});
```

### Cách 3: Lấy Safe Area Insets

```typescript
import React, { useEffect, useState } from 'react';
import { View, Text } from 'react-native';
import NativeViewIOS26 from 'native-view-ios-26';

export default function InsetsApp() {
  const [insets, setInsets] = useState({ top: 0, bottom: 0, left: 0, right: 0 });

  useEffect(() => {
    // Lấy insets
    NativeViewIOS26.getSafeAreaInsets().then(setInsets);

    // Lắng nghe thay đổi
    const sub = NativeViewIOS26.addSafeAreaListener(setInsets);
    return () => sub.remove();
  }, []);

  return (
    <View>
      <Text>Top: {insets.top}px</Text>
      <Text>Bottom: {insets.bottom}px</Text>
    </View>
  );
}
```

## 🐛 Xử lý lỗi thường gặp

### Lỗi 1: "NativeSafeAreaView was not found"

**Nguyên nhân:** Chưa link native module hoặc chưa rebuild

**Giải pháp:**
```bash
cd ios
pod install
cd ..
npx react-native run-ios
```

### Lỗi 2: "Cannot find module 'native-view-ios-26'"

**Nguyên nhân:** Chưa cài đặt package

**Giải pháp:**
```bash
npm install native-view-ios-26
# hoặc với local path
npm install /path/to/native-view-ios-26
```

### Lỗi 3: Swift compiler error

**Nguyên nhân:** Xcode chưa cấu hình Swift

**Giải pháp:**
1. Mở `ios/YourApp.xcworkspace` trong Xcode
2. Build Settings → Swift Language Version → chọn Swift 5
3. Clean build folder (Cmd + Shift + K)
4. Rebuild

### Lỗi 4: Module not registered

**Nguyên nhân:** ViewManager chưa được register

**Giải pháp:**
- Kiểm tra file `ios/NativeSafeAreaViewManager.m` tồn tại
- Rebuild app hoàn toàn

## 📝 TypeScript Support

Thư viện có sẵn TypeScript definitions. Nếu dùng TypeScript:

```typescript
import { 
  NativeSafeAreaView, 
  NativeSafeAreaScrollView,
  SafeAreaInsets 
} from 'native-view-ios-26';

// Types tự động available
const MyComponent: React.FC = () => {
  return <NativeSafeAreaView showBlur={true} />;
};
```

## 🧪 Test thư viện

### Test 1: Xem blur effect
```typescript
<NativeSafeAreaView showBlur={true} style={{ flex: 1, backgroundColor: 'white' }}>
  <Text>Kiểm tra blur effect dưới status bar</Text>
</NativeSafeAreaView>
```

### Test 2: Xem safe area insets
```typescript
NativeViewIOS26.getSafeAreaInsets().then(console.log);
// Nên thấy: { top: 47, bottom: 34, left: 0, right: 0 } (iPhone X trở lên)
```

### Test 3: Xoay màn hình
- Bật auto-rotation
- Xoay iPhone
- Blur effect và insets nên tự động cập nhật

## 🚀 Quick Start Template

Tạo file `App.tsx`:

```typescript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { NativeSafeAreaView, NativeSafeAreaScrollView } from 'native-view-ios-26';

export default function App() {
  return (
    <NativeSafeAreaView style={styles.container} showBlur={true}>
      <View style={styles.header}>
        <Text style={styles.title}>My App</Text>
      </View>
      
      <NativeSafeAreaScrollView style={styles.scrollView}>
        {Array.from({ length: 20 }).map((_, i) => (
          <View key={i} style={styles.card}>
            <Text>Card {i + 1}</Text>
          </View>
        ))}
      </NativeSafeAreaScrollView>
    </NativeSafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  header: {
    padding: 20,
    backgroundColor: '#f0f0f0',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
  },
  scrollView: {
    flex: 1,
  },
  card: {
    padding: 20,
    margin: 10,
    backgroundColor: '#fff',
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
});
```

Chạy app:
```bash
npx react-native run-ios
```

## 📚 Tài liệu thêm

- [README.md](README.md) - Tài liệu API đầy đủ
- [EXAMPLES.md](EXAMPLES.md) - 6 ví dụ chi tiết
- [EXAMPLE.md](EXAMPLE.md) - Ví dụ nâng cao

## 💡 Tips

1. **Luôn dùng `showBlur={true}`** để có blur effect đẹp
2. **Dùng NativeSafeAreaScrollView** thay vì ScrollView trong SafeAreaView
3. **Test trên thiết bị thật** để thấy blur effect rõ nhất
4. **Xoay màn hình** để test auto-update insets
