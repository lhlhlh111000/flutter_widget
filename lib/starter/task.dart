import 'dart:async';

abstract class Task {
  String get name;

  List<String> get dependencies => [];

  Future<void> execute();

  Duration? get timeout => null;
}

extension TimeoutTask on Task {
  Future<void> executeWithTimeout() async {
    if (timeout == null) {
      return execute();
    } else {
      final completer = Completer<void>();
      final timer = Timer(timeout!, () {
        completer.completeError(TimeoutException('Task ${name} timed out after ${timeout}'));
      });

      execute().whenComplete(() {
        if (!completer.isCompleted) {
          completer.complete();
          if (timer.isActive) {
            timer.cancel();
          }
        }
      }).catchError((error, stack) {
        if (!completer.isCompleted) {
          completer.completeError(error);
          if (timer.isActive) {
            timer.cancel();
          }
        }
      });

      return completer.future;
    }
  }
}
