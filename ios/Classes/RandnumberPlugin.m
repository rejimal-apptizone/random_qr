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
    long long timeInMilliSec = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    int randomNumber  = @(timeInMilliSec);
    result(@(randomNumber));
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
