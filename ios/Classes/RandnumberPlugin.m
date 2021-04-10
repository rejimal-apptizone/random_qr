#import "RandnumberPlugin.h"

@implementation RandnumberPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"randnumber"
            binaryMessenger:[registrar messenger]];
  RandnumberPlugin* instance = [[RandnumberPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getRandomNumber" isEqualToString:call.method]) {
    result(100);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
