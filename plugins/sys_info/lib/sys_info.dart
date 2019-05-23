import 'dart:async';

import 'package:flutter/services.dart';

class SysInfo {
  static const MethodChannel _channel =
      const MethodChannel('sys_info');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
