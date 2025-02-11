import '../task.dart';

class AnalyticsInitTask extends Task {
  @override
  String get name => 'analytics_init';

  @override
  Future<void> execute() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  List<String> get dependencies => ['database_init'];
}
