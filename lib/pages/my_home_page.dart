import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:widget_test/pages/controller/home_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return VisibilityDetector(
            key: const Key('home'),
            child: Column(
              children: [
                TabBar(
                  tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
                  controller: controller.tabController,
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: controller.tabs.map((e) {
                      return Center(
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            onVisibilityChanged: (info) {
              if (info.visibleFraction >= 0.8) {
                controller.onPageEnter();
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/second"),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
