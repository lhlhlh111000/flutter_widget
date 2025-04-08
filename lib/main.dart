import 'package:flutter/material.dart';
import 'package:sm_network/sm_network.dart';
import 'package:widget_test/pages/my_home_page.dart';
import 'package:widget_test/router/test_router_observer.dart';

void main() {
  Http.shared.config(
    options: HttpBaseOptions(
      baseUrl: 'https://www.wanandroid.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      validateStatus: (status) => status != null && status == 200,
      headers: {'user-agent': 'sm_network', 'common-header': 'xx', 'accept': 'application/json'},
      log: HttpLog(
        error: (error, stackTrace) {
          print('$error\n$stackTrace');
        },
      ),
      // ignore: avoid_redundant_argument_values
      converterOptions: DefaultConverterOptions(
        // ignore: avoid_redundant_argument_values
        code: 'errorCode',
        // ignore: avoid_redundant_argument_values
        data: 'data',
        // ignore: avoid_redundant_argument_values
        message: 'errorMsg',
        // ignore: avoid_redundant_argument_values
        status: (status, data) => status == 1,
      ),
    ),
    interceptors: [LogcatInterceptor()],
  );

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
