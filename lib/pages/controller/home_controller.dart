import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/tracker/tab_page_tracker.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin, TabPageTrackerMixin {
  final tabs = <String>['爽文', '玄幻', '穿越'];

  TabController get tabController => _tabController;
  late TabController _tabController;

  HomeController() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != _tabController.previousIndex) {
        onPageEnter();
      }
    });
  }

  @override
  int get trackPageIndex => _tabController.index;

  @override
  TabPageNameBuilder? get tabPageNameBuilder => (index) {
        return 'home_${tabs[index]}';
      };
}
