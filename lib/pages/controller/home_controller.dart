import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final tabs = <String>['爽文', '玄幻', '穿越'];

  TabController get tabController => _tabController;
  late TabController _tabController;

  HomeController() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {});
  }
}
