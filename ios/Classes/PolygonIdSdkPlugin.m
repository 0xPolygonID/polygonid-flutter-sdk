#import "PolygonIdSdkPlugin.h"
#if __has_include(<polygonid_flutter_sdk/polygonid_flutter_sdk-Swift.h>)
#import <polygonid_flutter_sdk/polygonid_flutter_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "polygonid_flutter_sdk-Swift.h"
#endif

@implementation PolygonIdSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [PolygonIdSdkPlugin registerWithRegistrar:registrar];
}
@end
