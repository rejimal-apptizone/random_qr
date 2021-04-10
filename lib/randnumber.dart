import 'dart:async';

import 'package:flutter/services.dart';

class Randnumber {
  static const MethodChannel _channel = const MethodChannel('randnumber');

  static Future<int> get getRandom async {
    final int randomNumber = await _channel.invokeMethod('getRandomNumber');
    return randomNumber;
  }
}
