import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/tracker/a_tracker.dart';

typedef TabPageNameBuilder = String Function(int index);

mixin TabPageTrackerMixin on GetxController {
  @required
  late int trackPageIndex = 0;

  @required
  TabPageNameBuilder? tabPageNameBuilder;

  @override
  void onInit() {
    super.onInit();

    onPageEnter();
  }

  void onPageEnter() {
    String pageName = tabPageNameBuilder?.call(trackPageIndex) ?? '';
    ATracker.onPageEnter(
      pageName: pageName,
      popExit: true,
    );
  }
}
