import 'package:sm_network/sm_network.dart';
import 'package:widget_test/net/hot_key.dart';

class GetHotKeySession extends Session<HotKey> {
  @override
  String get path => '/hotkey/json';

  @override
  FromJsonT<HotKey>? get fromJsonT => HotKey.fromJson;
}
