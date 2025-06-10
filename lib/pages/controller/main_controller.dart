import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  int get trackPageIndex => currentPage;

  @override
  void onInit() {
    super.onInit();

    /// mock hor message
    Future.delayed(
      3.seconds,
      () => Get.showSnackbar(
        GetSnackBar(
          title: 'hello',
          message: 'mock message',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          onTap: (_) {
            Get.back();
            Get.toNamed('/second');
          },
        ),
      ),
    );
  }

  void switchPage(int index) {
    currentPage = index;
    pageController.jumpToPage(index);

    update();
  }
}
