import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api_data/api_data.dart';

class AddLectureScreen extends StatefulWidget {
  const AddLectureScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddLectureScreenState createState() => _AddLectureScreenState();
}

class _AddLectureScreenState extends State<AddLectureScreen> {
  final QuillController _controller = QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  String _selectedDifficulty = 'Начинающий';

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      backgroundColor: const Color.fromRGBO(50, 53, 56, 1),
      appBar: material.AppBar(
        backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
        title: const material.Text('Добавить лекцию'),
        actions: [
          material.IconButton(
            onPressed: () {
              String title = _titleController.text;
              String description =
                  jsonEncode(_controller.document.toDelta().toJson());
              addLecture(title, description, _selectedDifficulty);
            },
            icon: const Icon(material.Icons.check),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          material.TextField(
            controller: _titleController,
            decoration: const material.InputDecoration(
              labelText: 'Название лекции',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            style: const TextStyle(
              color: Color.fromRGBO(236, 126, 74, 1),
            ),
          ),
          const SizedBox(height: 16.0),
          material.DropdownButtonFormField<String>(
            value: _selectedDifficulty,
            onChanged: (value) {
              setState(() {
                _selectedDifficulty = value!;
              });
            },
            items: <String>['Начинающий', 'Средний', 'Продвинутый']
                .map<material.DropdownMenuItem<String>>((String value) {
              return material.DropdownMenuItem<String>(
                value: value,
                child: material.Text(value),
              );
            }).toList(),
            decoration: const material.InputDecoration(
              labelText: 'Уровень сложности',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            style: const TextStyle(
              color: Color.fromRGBO(236, 126, 74, 1),
            ),
            dropdownColor: const Color.fromRGBO(55, 61, 65, 1),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: QuillEditor(
                    controller: _controller,
                    scrollController: ScrollController(),
                    scrollable: true,
                    focusNode: FocusNode(),
                    autoFocus: true,
                    readOnly: false,
                    placeholder: 'Введите описание лекции...',
                    expands: true,
                    padding: const EdgeInsets.all(16.0),
                    maxHeight: constraints.maxHeight -
                        material.kToolbarHeight -
                        48.0, // Adjust the maxHeight
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(55, 61, 65, 1),
        child: Container(
          color: const Color.fromRGBO(55, 61, 65, 1),
          child: QuillToolbar.basic(
            iconTheme: const QuillIconTheme(
              iconSelectedColor: Colors.white,
              iconSelectedFillColor: Color.fromRGBO(236, 126, 74, 1),
              iconUnselectedColor: Colors.white,
              iconUnselectedFillColor: Colors.grey,
              disabledIconColor: Colors.white,
            ),
            controller: _controller,
            showCodeBlock: false,
            showListCheck: true,
          ),
        ),
      ),
    );
  }

  Future<void> addLecture(
      String title, String description, String difficulty) async {
    try {
      final response = await http.post(
        Uri.parse(ApiData.addLecture),
        body: jsonEncode({
          'title': title,
          'description': description,
          'difficulty': difficulty,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true); // Возвращаемся к предыдущему экрану
      } else {
        showErrorMessage('Ошибка при добавлении лекции');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Ошибка при отправке запроса');
    }
  }

  void showErrorMessage(String message) {
    material.showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const material.Text('Ошибка'),
          content: material.Text(message),
          actions: [
            material.ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Закрываем диалоговое окно
              },
              child: const material.Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
