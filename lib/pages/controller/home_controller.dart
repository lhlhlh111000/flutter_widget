import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/pages/controller/FenixTestController.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final tabs = <String>['爽文', '玄幻', '穿越'];

  TabController get tabController => _tabController;
  late TabController _tabController;

  HomeController() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  void onInit() {
    super.onInit();

    Future.delayed(50.milliseconds, () {
      Get.generalDialog(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return const Material(
            color: Colors.transparent,
            child: SizedBox(width: 300, height: 300),
          );
        },
        barrierLabel: '',
      );
    });

    Future.delayed(100.milliseconds, () {
      final controller = Get.find<FenixTestController>();
      controller.count.value = 2;
    });
  }
}
