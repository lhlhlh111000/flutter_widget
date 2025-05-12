import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/pages/business_page.dart';
import 'package:widget_test/pages/controller/main_controller.dart';
import 'package:widget_test/pages/my_home_page.dart';
import 'package:widget_test/pages/web_page.dart' show WebPage;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: [
              const MyHomePage(title: 'Flutter Demo Home Page'),
              const BusinessPage(),
              WebPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            onTap: (index) {
              controller.switchPage(index);
            },
          ),
        );
      },
    );
  }
}
