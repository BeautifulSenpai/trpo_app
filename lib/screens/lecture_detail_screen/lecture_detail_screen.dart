import 'dart:convert';

import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class LectureDetailScreen extends StatelessWidget {
  final dynamic lecture;

  const LectureDetailScreen({super.key, required this.lecture});

  @override
  Widget build(BuildContext context) {
    final String descriptionString = lecture['description'];
    final List<dynamic> descriptionList = jsonDecode(descriptionString);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 53, 56, 1),
      appBar: material.AppBar(
        backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
        title: const material.Text('Детали лекции'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return QuillEditor(
                    controller: QuillController(
                      document: Document.fromJson(descriptionList),
                      selection: const TextSelection.collapsed(offset: 0),
                    ),
                    readOnly: true,
                    scrollable: true,
                    autoFocus: false,
                    expands: true,
                    focusNode: FocusNode(),
                    padding: const EdgeInsets.all(10.0),
                    scrollController: ScrollController(),
                    maxHeight:
                        constraints.maxHeight - material.kToolbarHeight - 48.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
