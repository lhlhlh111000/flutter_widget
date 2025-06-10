import 'package:get/get.dart';
import 'package:widget_test/pages/controller/FenixTestController.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FenixTestController(), fenix: true);
  }
}
