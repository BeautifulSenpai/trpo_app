import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizScreen extends StatefulWidget {
  final String apiUrl;

  const QuizScreen({Key? key, required this.apiUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> quizzes = [];
  List<String> selectedAnswers = [];
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    final response = await http.get(Uri.parse(widget.apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        quizzes = json.decode(response.body);
        selectedAnswers = List<String>.filled(quizzes.length, '');
      });
    }
  }

  void handleOptionSelection(String option) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = option;
    });
  }

  void submitAnswer() {
    final quiz = quizzes[currentQuestionIndex];
    final correctAnswer = quiz['answer'];
    if (selectedAnswers[currentQuestionIndex] == correctAnswer) {
      score++;
    }
    if (currentQuestionIndex < quizzes.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromRGBO(236, 126, 74, 1),
                    radius: 48.0,
                    child: Text(
                      '$score',
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Результат викторины',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Ваш счет: $score/${quizzes.length}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      resetQuiz();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: const Color.fromRGBO(236, 126, 74, 1),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void resetQuiz() {
    setState(() {
      selectedAnswers = List<String>.filled(quizzes.length, '');
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quiz = quizzes.isNotEmpty ? quizzes[currentQuestionIndex] : null;
    final options = quiz != null ? quiz['options'].split(';') : [];
    final questionNumber = currentQuestionIndex + 1;
    final totalQuestions = quizzes.length;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 53, 56, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(55, 61, 65, 1),
        title: const Text('Тест'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (quiz != null) ...[
              Text(
                quiz['question'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color.fromRGBO(236, 126, 74, 1),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                children: List.generate(
                  options.length,
                  (optionIndex) => GestureDetector(
                    onTap: () {
                      handleOptionSelection(options[optionIndex]);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: selectedAnswers[currentQuestionIndex] ==
                                options[optionIndex]
                            ? const Color.fromRGBO(236, 126, 74, 1)
                            : const Color.fromRGBO(55, 61, 65, 1),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          options[optionIndex],
                          style: TextStyle(
                            color: selectedAnswers[currentQuestionIndex] ==
                                    options[optionIndex]
                                ? Colors.white
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$questionNumber/$totalQuestions',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(236, 126, 74, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                  ),
                  child: const Text('Ответить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
