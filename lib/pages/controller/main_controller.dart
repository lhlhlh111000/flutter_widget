import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  int get trackPageIndex => currentPage;

  void switchPage(int index) {
    currentPage = index;
    pageController.jumpToPage(index);

    update();
  }
}
