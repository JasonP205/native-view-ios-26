#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(NativeSafeAreaViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(showBlur, BOOL)

@end

@interface RCT_EXTERN_MODULE(NativeSafeAreaScrollViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(showBlur, BOOL)
RCT_EXPORT_VIEW_PROPERTY(scrollEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(showsVerticalScrollIndicator, BOOL)
RCT_EXPORT_VIEW_PROPERTY(showsHorizontalScrollIndicator, BOOL)

@end
