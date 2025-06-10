import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/pages/bindings/HomeBindings.dart';
import 'package:widget_test/pages/main_page.dart';
import 'package:widget_test/pages/second_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
            binding: HomeBindings(),
          ),
          GetPage(
            name: '/second',
            page: () => const SecondPage(),
          ),
        ]);
  }
}
