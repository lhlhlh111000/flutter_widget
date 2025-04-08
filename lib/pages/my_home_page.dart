import 'package:flutter/material.dart';
import 'package:widget_test/net/get_hot_key_session.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String msg = 'init';

  Future<void> _testNet() async {
    setState(() {
      _counter++;
    });

    final resp = await GetHotKeySession().request();
    setState(() {
      msg = resp.list.toString() ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              msg,
            ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _testNet,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
