import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_load_listview/lazy_load_listview_method_channel.dart';

void main() {
  MethodChannelLazyLoadListview platform = MethodChannelLazyLoadListview();
  const MethodChannel channel = MethodChannel('lazy_load_listview');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
