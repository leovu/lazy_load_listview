import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lazy_load_listview_platform_interface.dart';

/// An implementation of [LazyLoadListviewPlatform] that uses method channels.
class MethodChannelLazyLoadListview extends LazyLoadListviewPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lazy_load_listview');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
