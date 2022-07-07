import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lazy_load_listview_method_channel.dart';

abstract class LazyLoadListviewPlatform extends PlatformInterface {
  /// Constructs a LazyLoadListviewPlatform.
  LazyLoadListviewPlatform() : super(token: _token);

  static final Object _token = Object();

  static LazyLoadListviewPlatform _instance = MethodChannelLazyLoadListview();

  /// The default instance of [LazyLoadListviewPlatform] to use.
  ///
  /// Defaults to [MethodChannelLazyLoadListview].
  static LazyLoadListviewPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LazyLoadListviewPlatform] when
  /// they register themselves.
  static set instance(LazyLoadListviewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
