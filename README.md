# native-view-ios-26

Native iOS Safe Area module for React Native với Swift bridge. Thư viện này cung cấp 2 native components với blur effect dưới status bar và API để truy xuất thông tin safe area insets.

## Tính năng

- ✅ `<NativeSafeAreaView>` - Native view với safe area và blur effect
- ✅ `<NativeSafeAreaScrollView>` - Native scroll view với safe area và blur effect
- ✅ Blur effect tự động dưới status bar (systemMaterial blur)
- ✅ Lấy safe area insets hiện tại (top, bottom, left, right)
- ✅ Lắng nghe thay đổi safe area khi xoay màn hình
- ✅ Hỗ trợ iOS 13+ và iOS 26
- ✅ Viết bằng Swift với hiệu suất cao
- ✅ TypeScript support đầy đủ

## Cài đặt

```bash
npm install native-view-ios-26
# hoặc
yarn add native-view-ios-26
```

### iOS

Sau khi cài đặt, chạy lệnh sau để cài đặt CocoaPods dependencies:

```bash
cd ios && pod install && cd ..
```

## Sử dụng

### 1. Native Components với Blur Effect

#### NativeSafeAreaView

Component view cơ bản với safe area insets và blur effect dưới status bar:

```javascript
import { NativeSafeAreaView } from 'native-view-ios-26';

function App() {
  return (
    <NativeSafeAreaView style={{ flex: 1, backgroundColor: 'white' }}>
      <Text>Nội dung tự động có padding safe area</Text>
      <Text>Blur effect xuất hiện dưới status bar</Text>
    </NativeSafeAreaView>
  );
}
```

**Props:**
- `showBlur?: boolean` - Hiển thị blur effect (mặc định: `true`)
- `style?: ViewStyle` - Style cho view

#### NativeSafeAreaScrollView

Component scroll view với safe area insets và blur effect dưới status bar:

```javascript
import { NativeSafeAreaScrollView } from 'native-view-ios-26';

function App() {
  return (
    <NativeSafeAreaScrollView 
      style={{ flex: 1 }}
      showBlur={true}
      showsVerticalScrollIndicator={true}
    >
      <Text>Nội dung có thể scroll</Text>
      <Text>Blur effect luôn cố định dưới status bar</Text>
      {/* More content... */}
    </NativeSafeAreaScrollView>
  );
}
```

**Props:**
- `showBlur?: boolean` - Hiển thị blur effect (mặc định: `true`)
- `scrollEnabled?: boolean` - Cho phép scroll (mặc định: `true`)
- `showsVerticalScrollIndicator?: boolean` - Hiển thị thanh scroll dọc (mặc định: `true`)
- `showsHorizontalScrollIndicator?: boolean` - Hiển thị thanh scroll ngang (mặc định: `false`)
- `style?: ViewStyle` - Style cho scroll view

### 2. Tắt Blur Effect

```javascript
// Không hiển thị blur effect
<NativeSafeAreaView showBlur={false}>
  <Text>Không có blur effect</Text>
</NativeSafeAreaView>

<NativeSafeAreaScrollView showBlur={false}>
  <Text>Scroll view không có blur effect</Text>
</NativeSafeAreaScrollView>
```

### 3. Lấy Safe Area Insets programmatically

### 3. Lấy Safe Area Insets programmatically

```javascript
import NativeViewIOS26 from 'native-view-ios-26';

// Lấy safe area insets
const insets = await NativeViewIOS26.getSafeAreaInsets();
console.log('Safe Area Insets:', insets);
// Output: { top: 47, bottom: 34, left: 0, right: 0 }
```

### 4. Lắng nghe thay đổi Safe Area

```javascript
import { useEffect, useState } from 'react';
import NativeViewIOS26 from 'native-view-ios-26';

function App() {
  const [insets, setInsets] = useState({ top: 0, bottom: 0, left: 0, right: 0 });

  useEffect(() => {
    // Lấy giá trị ban đầu
    NativeViewIOS26.getSafeAreaInsets().then(setInsets);

    // Đăng ký listener
    const subscription = NativeViewIOS26.addSafeAreaListener((newInsets) => {
      console.log('Safe area changed:', newInsets);
      setInsets(newInsets);
    });

    // Cleanup
    return () => {
      subscription.remove();
    };
  }, []);

  return (
    <View style={{ 
      paddingTop: insets.top,
      paddingBottom: insets.bottom,
      paddingLeft: insets.left,
      paddingRight: insets.right 
    }}>
      <Text>Top: {insets.top}</Text>
      <Text>Bottom: {insets.bottom}</Text>
      <Text>Left: {insets.left}</Text>
      <Text>Right: {insets.right}</Text>
    </View>
  );
}
```

## API Reference

### Components

#### `<NativeSafeAreaView>`

Native view component với automatic safe area insets và blur effect.

**Props:**
```typescript
interface NativeSafeAreaViewProps {
  showBlur?: boolean;        // Default: true
  style?: ViewStyle;
  children?: React.ReactNode;
}
```

#### `<NativeSafeAreaScrollView>`

Native scroll view component với automatic safe area insets và blur effect.

**Props:**
```typescript
interface NativeSafeAreaScrollViewProps {
  showBlur?: boolean;                      // Default: true
  scrollEnabled?: boolean;                  // Default: true
  showsVerticalScrollIndicator?: boolean;   // Default: true
  showsHorizontalScrollIndicator?: boolean; // Default: false
  style?: ViewStyle;
  children?: React.ReactNode;
}
```

### Methods

### `getSafeAreaInsets()`

Trả về Promise với safe area insets hiện tại.

**Returns:**
```typescript
Promise<{
  top: number;
  bottom: number;
  left: number;
  right: number;
}>
```

### `addSafeAreaListener(callback)`

Đăng ký listener để nhận thông báo khi safe area thay đổi (ví dụ: khi xoay màn hình).

**Parameters:**
- `callback: (insets: SafeAreaInsets) => void` - Hàm được gọi khi safe area thay đổi

**Returns:**
```typescript
{
  remove: () => void;
}
```

## Yêu cầu hệ thống

- React Native >= 0.60
- iOS >= 13.0
- Swift 5.0+

## Lưu ý

- Thư viện này chỉ hoạt động trên iOS
- Blur effect sử dụng `UIVisualEffectView` với style `systemMaterial`
- Blur effect tự động điều chỉnh theo Dark Mode / Light Mode của hệ thống
- Safe area insets có thể thay đổi khi:
  - Xoay màn hình
  - Hiển thị/ẩn thanh trạng thái
  - Thay đổi layout của ứng dụng
- `NativeSafeAreaScrollView` tự động set content insets phù hợp với safe area

## So sánh với SafeAreaView mặc định

| Feature | React Native SafeAreaView | NativeSafeAreaView | NativeSafeAreaScrollView |
|---------|--------------------------|-------------------|-------------------------|
| Safe Area Padding | ✅ | ✅ | ✅ |
| Blur Effect dưới Status Bar | ❌ | ✅ | ✅ |
| Hoạt động trong ScrollView | ❌ (bị lỗi trên iOS 26) | ✅ | ✅ (built-in scroll) |
| Auto Content Inset | ❌ | N/A | ✅ |
| Native Performance | ❌ (JS) | ✅ (Swift) | ✅ (Swift) |

## Ví dụ thực tế

### Màn hình với Header và Content

```javascript
import { NativeSafeAreaView } from 'native-view-ios-26';
import { View, Text, StyleSheet } from 'react-native';

function HomeScreen() {
  return (
    <NativeSafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>My App</Text>
      </View>
      <View style={styles.content}>
        <Text>Main content here</Text>
      </View>
    </NativeSafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    padding: 16,
    backgroundColor: '#f0f0f0',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
  },
  content: {
    flex: 1,
    padding: 16,
  },
});
```

### Scroll View với nhiều nội dung

```javascript
import { NativeSafeAreaScrollView } from 'native-view-ios-26';
import { View, Text, Image, StyleSheet } from 'react-native';

function ArticleScreen() {
  return (
    <NativeSafeAreaScrollView 
      style={styles.container}
      showBlur={true}
      showsVerticalScrollIndicator={true}
    >
      <Image source={{ uri: 'https://...' }} style={styles.image} />
      <View style={styles.content}>
        <Text style={styles.title}>Article Title</Text>
        <Text style={styles.body}>
          Long article content that scrolls...
        </Text>
      </View>
    </NativeSafeAreaScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  image: {
    width: '100%',
    height: 300,
  },
  content: {
    padding: 16,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 16,
  },
  body: {
    fontSize: 16,
    lineHeight: 24,
  },
});
```

## Lưu ý

- Thư viện này chỉ hoạt động trên iOS
- Safe area insets có thể thay đổi khi:
  - Xoay màn hình
  - Hiển thị/ẩn thanh trạng thái
  - Thay đổi layout của ứng dụng

## License

MIT

## Tác giả

Jason Phan

## Đóng góp

Mọi đóng góp đều được chào đón! Vui lòng tạo pull request hoặc issue trên GitHub.
