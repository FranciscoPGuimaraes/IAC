//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<internet_speed_test/InternetSpeedTestPlugin.h>)
#import <internet_speed_test/InternetSpeedTestPlugin.h>
#else
@import internet_speed_test;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [InternetSpeedTestPlugin registerWithRegistrar:[registry registrarForPlugin:@"InternetSpeedTestPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
}

@end
