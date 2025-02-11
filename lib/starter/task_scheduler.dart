import 'package:widget_test/starter/task.dart';

class TaskScheduler {
  final List<Task> _tasks;
  final Set<String> _completedTasks = {};
  final Set<String> _failedTasks = {};

  TaskScheduler({required List<Task> tasks}) : _tasks = tasks;

  Future<void> execute() async {
    final sTime = DateTime.now().millisecondsSinceEpoch;
    print('schedule task start.');
    final independentTasks = _tasks.where((t) => t.dependencies.isEmpty);
    await _executeTasks(independentTasks.toList());

    print('schedule task finished, total time: ${DateTime.now().millisecondsSinceEpoch - sTime}');
  }

  Future<void> _executeTasks(List<Task> tasks) async {
    final List<Future> futures = [];

    // print('scheduler step 1.');
    for (final task in tasks) {
      if (_completedTasks.contains(task.name) || _failedTasks.contains(task.name)) {
        continue;
      }

      // 检查依赖是否完成
      final allDepTask = task.dependencies.every((dep) => _completedTasks.contains(dep));
      if (!allDepTask) continue;

      final sTime = DateTime.now().millisecondsSinceEpoch;
      print('[${task.name}] task start');

      final future = task.executeWithTimeout().catchError((error, stack) {
        _failedTasks.add(task.name);
        print('[${task.name}] task failed, error: $error');
      }).whenComplete(() {
        _completedTasks.add(task.name);
        print('[${task.name}] task completed, total time: ${DateTime.now().millisecondsSinceEpoch - sTime}');
      });

      futures.add(future);
    }

    // print('scheduler step 2. futures size ${futures.length}');
    await Future.wait(futures);

    // 递归执行剩余任务
    final remainingTasks = _tasks.where((t) => !_completedTasks.contains(t.name) && !_failedTasks.contains(t.name)).toList();
    if (remainingTasks.isNotEmpty) {
      // print('scheduler step 3.');
      await _executeTasks(remainingTasks);
    }
  }

  bool get allTasksCompleted => _completedTasks.length == _tasks.length;

  int get allTasksLength => _tasks.length;

  int get completedTasksLength => _completedTasks.length;
}
