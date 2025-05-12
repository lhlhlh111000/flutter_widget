import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/tracker/tab_page_tracker.dart';

class MainController extends GetxController with TabPageTrackerMixin {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  int get trackPageIndex => currentPage;

  @override
  TabTrackDetector? get tabTrackDetector => (index) {
        /// filter home page
        return index != 0;
      };

  @override
  TabPageNameBuilder get tabPageNameBuilder => (index) {
        switch (index) {
          case 1:
            return 'business';
          case 2:
            return 'school';
          default:
            return '';
        }
      };

  @override
  void onInit() {
    super.onInit();

    onPageEnter();
  }

  void switchPage(int index) {
    currentPage = index;
    pageController.jumpToPage(index);

    onPageEnter();

    update();
  }
}
