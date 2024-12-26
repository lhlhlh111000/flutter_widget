import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'second_page.dart';

class WebPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://github.com/'));

  @override
  void initState() {
    super.initState();

    controller.platform.setOnScrollPositionChange((position) {
      print('AAAAAA${position.x}_${position.y}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebPage'),
      ),
      body: WebViewWidget(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
