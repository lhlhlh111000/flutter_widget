import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/middlewares/GlobalMiddlewares.dart';
import 'package:widget_test/pages/my_home_page.dart';
import 'package:widget_test/pages/second_page.dart';
import 'package:widget_test/router/test_router_observer.dart';
import 'package:widget_test/tracker/a_tracker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ATracker.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final TestRouterObserver sObserver = TestRouterObserver();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
        GetPage(
          name: '/second',
          page: () => const SecondPage(),
        ),
      ]
          .map((e) => e = e.copy(middlewares: [
                GlobalMiddlewares(
                  pageName: e.name,
                ),
                ...e.middlewares ?? []
              ]))
          .toList(),
    );
  }
}
