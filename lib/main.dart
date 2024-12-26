import 'package:flutter/material.dart';
import 'package:widget_test/pages/my_home_page.dart';
import 'package:widget_test/router/test_router_observer.dart';

void main() {
  runApp(const MyApp());
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
