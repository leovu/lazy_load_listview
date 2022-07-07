#import "LazyLoadListviewPlugin.h"
#if __has_include(<lazy_load_listview/lazy_load_listview-Swift.h>)
#import <lazy_load_listview/lazy_load_listview-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lazy_load_listview-Swift.h"
#endif

@implementation LazyLoadListviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLazyLoadListviewPlugin registerWithRegistrar:registrar];
}
@end
