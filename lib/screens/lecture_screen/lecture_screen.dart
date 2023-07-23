import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trpo_app/screens/api_data/api_data.dart';
import 'package:trpo_app/screens/difficulty_indicator/difficulty_indicator.dart';
import 'dart:convert';
import 'package:trpo_app/screens/lecture_detail_screen/lecture_detail_screen.dart';
import 'package:trpo_app/screens/login_screen/login_student_screen.dart';
import 'package:trpo_app/screens/practice_screen/practice_screen.dart';
import 'package:trpo_app/screens/test_screen/test_screen.dart';

class LectureScreen extends StatefulWidget {
  const LectureScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LectureScreenState createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  List<dynamic> lectures = [];

  @override
  void initState() {
    super.initState();
    fetchLectures();
  }

  Future<void> fetchLectures() async {
    try {
      final response = await http.get(Uri.parse(ApiData.lectureScreen));
      if (response.statusCode == 200) {
        setState(() {
          lectures = jsonDecode(response.body);
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

  void _goToLoginStudentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginStudentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 53, 56, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
        title: const Text('Лекции'),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.assignment),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TestScreen(),
                    ),
                  );
                },
                tooltip: 'Открыть Тесты',
              ),
              IconButton(
                icon: const Icon(Icons.book),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PracticeScreen(
                        url: ApiData.practiceUrl,
                      ),
                    ),
                  );
                },
                tooltip: 'Перейти к практике',
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _goToLoginStudentScreen,
            tooltip: 'Выйти',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.builder(
          itemCount: lectures.length,
          itemBuilder: (context, index) {
            final lecture = lectures[index];
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
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/lecture.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  lecture['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(236, 126, 74, 1),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          DifficultyIndicator(
                              difficulty: lecture['difficulty'] ?? ''),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(236, 126, 74, 1),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LectureDetailScreen(lecture: lecture),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
