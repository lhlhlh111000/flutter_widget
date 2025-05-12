import 'package:flutter/material.dart';

class BusinessPage extends StatelessWidget with RouteAware {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BusinessPage'),
      ),
      body: const Center(
        child: Text('BusinessPage'),
      ),
    );
  }
}
