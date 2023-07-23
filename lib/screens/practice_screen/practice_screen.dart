import 'package:webviewx/webviewx.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatelessWidget {
  final String url;

  const PracticeScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
        title: const Text('Практическая работа'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return WebViewX(
            initialContent: url,
            height: constraints.maxHeight,
            width: constraints.maxWidth,
          );
        },
      ),
    );
  }
}
