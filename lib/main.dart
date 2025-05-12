import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/middlewares/GlobalMiddlewares.dart';
import 'package:widget_test/pages/main_page.dart';
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
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => MainPage(),
            children: [
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
          ),
        ]);
  }
}
