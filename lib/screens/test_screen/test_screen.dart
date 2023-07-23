import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trpo_app/screens/api_data/api_data.dart';
import 'package:trpo_app/screens/quiz_api_helper/quiz_api_helper.dart';
import 'dart:convert';

import 'package:trpo_app/screens/quiz_screen/quiz_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<dynamic> tests = [];

  @override
  void initState() {
    super.initState();
    fetchTests();
  }

  Future<void> fetchTests() async {
    try {
      final response = await http.get(Uri.parse(ApiData.testScreen));
      if (response.statusCode == 200) {
        setState(() {
          tests = jsonDecode(response.body);
        });
      } else {
        // ignore: avoid_print
        print('Ошибка при получении лекций');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Ошибка при отправке запроса');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 53, 56, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
        title: const Text('Тесты'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.builder(
          itemCount: tests.length,
          itemBuilder: (context, index) {
            final test = tests[index];
            return Card(
              color: const Color.fromRGBO(55, 61, 65, 1),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/quiz.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  test['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(236, 126, 74, 1),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(236, 126, 74, 1),
                ),
                onTap: () {
                  String? quizApiUrl =
                      QuizApiHelper.getQuizApiUrl(test['title']);
                  if (quizApiUrl != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(apiUrl: quizApiUrl),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
