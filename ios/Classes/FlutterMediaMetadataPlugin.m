#import "FlutterMediaMetadataPlugin.h"
#if __has_include(<flutter_media_metadata_plus/flutter_media_metadata_plus-Swift.h>)
#import <flutter_media_metadata_plus/flutter_media_metadata_plus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_media_metadata_plus-Swift.h"
#endif

@implementation FlutterMediaMetadataPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMediaMetadataPlugin registerWithRegistrar:registrar];
}
@end
