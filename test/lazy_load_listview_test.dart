import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_load_listview/lazy_load_listview.dart';
import 'package:lazy_load_listview/lazy_load_listview_platform_interface.dart';
import 'package:lazy_load_listview/lazy_load_listview_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLazyLoadListviewPlatform 
    with MockPlatformInterfaceMixin
    implements LazyLoadListviewPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LazyLoadListviewPlatform initialPlatform = LazyLoadListviewPlatform.instance;

  test('$MethodChannelLazyLoadListview is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLazyLoadListview>());
  });

  test('getPlatformVersion', () async {
    LazyLoadListview lazyLoadListviewPlugin = LazyLoadListview();
    MockLazyLoadListviewPlatform fakePlatform = MockLazyLoadListviewPlatform();
    LazyLoadListviewPlatform.instance = fakePlatform;
  
    expect(await lazyLoadListviewPlugin.getPlatformVersion(), '42');
  });
}
