import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:randnumber/randnumber.dart';

void main() {
  const MethodChannel channel = MethodChannel('randnumber');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getRandom', () async {
    expect(await Randnumber.getRandom, 42);
  });
}
