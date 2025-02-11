import 'package:flutter/material.dart';
import 'package:widget_test/pages/my_home_page.dart';
import 'package:widget_test/router/test_router_observer.dart';
import 'package:widget_test/starter/task_scheduler.dart';
import 'package:widget_test/starter/tasks/analytics_init_task.dart';
import 'package:widget_test/starter/tasks/config_load_task.dart';
import 'package:widget_test/starter/tasks/database_init_task.dart';
import 'package:widget_test/starter/tasks/exception_init_task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final scheduler = TaskScheduler(tasks: [
    ExceptionInitTask(),
    ConfigLoadTask(),
    DatabaseInitTask(),
    AnalyticsInitTask(),
  ]);

  runApp(FutureBuilder(
    future: scheduler.execute(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return const MyApp();
      }
      return _LaunchScreen(
        progress: scheduler.completedTasksLength.toDouble() / scheduler.allTasksLength,
      );
    },
  ));
}

class MyApp extends StatelessWidget {
  static final TestRouterObserver sObserver = TestRouterObserver();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorObservers: [sObserver],
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class _CriticalErrorWidget extends StatelessWidget {
  const _CriticalErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error...'),
        ),
      ),
    );
  }
}

class _LaunchScreen extends StatelessWidget {
  final double progress;

  const _LaunchScreen({required this.progress});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(value: progress),
              Text('Initializing... ${(progress * 100).toStringAsFixed(0)}%'),
            ],
          ),
        ),
      ),
    );
  }
}
