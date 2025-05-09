import 'package:flutter/material.dart';

mixin ATracker {
  static final historyPageStack = <Page>[];

  static void init() {
    WidgetsBinding.instance.addObserver(AWidgetsBindingObserver());
  }

  static void onPageEnter({required String pageName, String? type}) {
    final pageType = type ?? 'normal';

    Page? prePage;
    if (historyPageStack.isNotEmpty) {
      prePage = historyPageStack.last;
    }

    final enterPage = Page(name: pageName, type: pageType, prePage: prePage);
    historyPageStack.add(enterPage);

    _trackExit(prePage);
    _trackEnter(enterPage, prePage);
  }

  static void onPageClose() {
    if (historyPageStack.isEmpty) {
      return;
    }

    final lastPage = historyPageStack.removeLast();
    _trackExit(lastPage);
    _trackEnter(lastPage.prePage, lastPage);
  }

  static void _trackExit(Page? page) {
    if (page?.name.isEmpty ?? true) {
      return;
    }

    print('[ATracker] ${page?.name} exit');
  }

  static void _trackEnter(Page? page, Page? exitPage) {
    if (page?.name.isEmpty ?? true) {
      return;
    }

    final fromType = exitPage?.typeName ?? 'unknown';

    print('[ATracker] ${page?.name} enter, from $fromType');
  }
}

class Page {
  Page({
    this.name = '',
    this.type = 'unknown',
    this.prePage,
  });

  final String name;

  final String type;

  final Page? prePage;

  String get typeName {
    if (name.isNotEmpty) {
      return 'preview';
    }
    if (type.isNotEmpty) {
      return type;
    }
    return 'unknown';
  }
}

class AWidgetsBindingObserver extends WidgetsBindingObserver {
  bool inBackground = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // 过滤抖动
        if (inBackground) {
          ATracker.onPageClose();
        }

        inBackground = false;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        inBackground = true;
        ATracker.onPageEnter(pageName: '', type: 'background');
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
