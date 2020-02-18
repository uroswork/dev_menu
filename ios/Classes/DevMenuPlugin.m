#import "DevMenuPlugin.h"
#if __has_include(<dev_menu/dev_menu-Swift.h>)
#import <dev_menu/dev_menu-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dev_menu-Swift.h"
#endif

@implementation DevMenuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDevMenuPlugin registerWithRegistrar:registrar];

   FlutterMethodChannel* channel =
      [FlutterMethodChannel methodChannelWithName:@"devmenu.flutter.io/packageInfo"
                                  binaryMessenger:[registrar messenger]];
  DevMenuPlugin* instance = [[DevMenuPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([call.method isEqualToString:@"getPackageInfo"]) {
    result(@{
      @"appName" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
          ?: [NSNull null],
      @"packageName" : [[NSBundle mainBundle] bundleIdentifier] ?: [NSNull null],
      @"version" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
          ?: [NSNull null],
    });
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
