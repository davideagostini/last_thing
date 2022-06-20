import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelService {
  static const MethodChannel channel =
      MethodChannel('last_thing/accessChannel');

  Future<void> changeStatusBar(String value, String hexColor) async {
    try {
      final String result =
          await ChannelService.channel.invokeMethod('changeStatusBar', {
        "value": value,
        "hexColor": hexColor,
      });
      debugPrint('Result: $result ');
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }

  Future<void> exitApp() async {
    try {
      final String result =
          await ChannelService.channel.invokeMethod('exitApp');
      debugPrint('Result: $result ');
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
}
