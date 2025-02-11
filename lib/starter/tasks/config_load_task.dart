import '../task.dart';

class ConfigLoadTask extends Task {
  @override
  String get name => 'config_load';

  @override
  Future<void> execute() async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }
}
