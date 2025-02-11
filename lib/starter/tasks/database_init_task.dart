import 'package:widget_test/starter/task.dart';

class DatabaseInitTask extends Task {
  @override
  Future<void> execute() async {
    await Future.delayed(const Duration(milliseconds: 5000));
  }

  @override
  String get name => 'database_init';

  @override
  Duration? get timeout => const Duration(seconds: 3);
}
