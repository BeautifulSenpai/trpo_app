import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api_data/api_data.dart';
import '../request/student.dart';

class AllStudentsScreen extends StatefulWidget {
  @override
  _AllStudentsScreenState createState() => _AllStudentsScreenState();
}

class _AllStudentsScreenState extends State<AllStudentsScreen> {
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    final response = await http.get(Uri.parse(ApiData.approvedStudents));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _students = responseData
            .map((studentJson) => Student.fromJson(studentJson))
            .toList();
      });
    } else {
      // Обработка ошибки, если запрос не успешен
      print('Failed to fetch students. Status code: ${response.statusCode}');
    }
  }

  Future<void> _deleteStudent(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('${ApiData.deleteStudent}/$id'));

      if (response.statusCode == 200) {
        // Удаление успешно выполнено
        // Обновите список студентов на экране, если необходимо
        await _fetchStudents();
        print('Student with ID $id has been deleted.');
      } else {
        // Обработка ошибки, если запрос не удался
        print(
            'Failed to delete student with ID $id. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Обработка ошибки, если возникла ошибка в процессе выполнения запроса
      print('Error while deleting student with ID $id: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 53, 56, 1),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return ListTile(
            title: Text(
              'Номер зачетной книжки: ${student.studentId}',
              style: const TextStyle(
                color: Color.fromRGBO(
                    236, 126, 74, 1), // Измените цвет текста заголовка
                fontSize: 16, // Измените размер текста заголовка
                fontWeight:
                    FontWeight.bold, // Измените начертание текста заголовка
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
                      title: const Text(
                        'Удаление студента',
                        style: TextStyle(
                          color: Color.fromRGBO(236, 126, 74, 1),
                        ),
                      ),
                      content: const Text(
                        'Вы уверены, что хотите удалить студента?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Отмена',
                            style: TextStyle(
                              color: Color.fromRGBO(236, 126, 74, 1),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _deleteStudent(student.id);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Удалить',
                            style: TextStyle(
                              color: Color.fromRGBO(236, 126, 74, 1),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
