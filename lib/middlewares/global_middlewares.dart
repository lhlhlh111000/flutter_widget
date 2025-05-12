import 'package:get/get.dart';
import 'package:widget_test/tracker/a_tracker.dart';

class GlobalMiddlewares extends GetMiddleware {
  GlobalMiddlewares({
    required this.pageName,
  });

  final String pageName;

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    ATracker.onPageEnter(pageName: pageName);
    return super.onPageBuildStart(page);
  }

  @override
  void onPageDispose() {
    ATracker.onPageClose();
    super.onPageDispose();
  }
}
