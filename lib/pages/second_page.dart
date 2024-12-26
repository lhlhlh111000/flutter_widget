import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget with RouteAware {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: const Center(
        child: Text('Second Page'),
      ),
    );
  }
}
