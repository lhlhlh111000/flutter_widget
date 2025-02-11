import 'package:widget_test/starter/task.dart';

class ExceptionInitTask extends Task {
  @override
  Future<void> execute() async {
    await Future.delayed(const Duration(seconds: 4));
    throw ArgumentError('test error');
  }

  @override
  String get name => 'exception_init';

  @override
  List<String> get dependencies => ['config_load'];
}
