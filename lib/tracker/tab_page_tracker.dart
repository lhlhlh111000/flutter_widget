import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_test/tracker/a_tracker.dart';

typedef TabPageNameBuilder = String Function(int index);

typedef TabTrackDetector = bool Function(int index);

mixin TabPageTrackerMixin on GetxController {
  @required
  late int trackPageIndex = 0;

  @required
  TabPageNameBuilder? tabPageNameBuilder;

  @required
  TabTrackDetector? tabTrackDetector;

  void onPageEnter() {
    if (!(tabTrackDetector?.call(trackPageIndex) ?? true)) {
      return;
    }

    String pageName = tabPageNameBuilder?.call(trackPageIndex) ?? '';
    ATracker.onPageEnter(
      pageName: pageName,
      popExit: true,
    );
  }
}
