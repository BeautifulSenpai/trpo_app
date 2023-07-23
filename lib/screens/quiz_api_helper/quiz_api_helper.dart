import 'package:trpo_app/screens/api_data/api_data.dart';

class QuizApiHelper {
  static String? getQuizApiUrl(String testTitle) {
    if (testTitle == 'Тест на тему "Синтаксис"') {
      return ApiData.quizSyntax;
    } else if (testTitle == 'Тест на тему "Типы и объекты"') {
      return ApiData.quizTypeObject;
    } else if (testTitle == 'Тест на тему "Типы операторов"') {
      return ApiData.quizTypeOperator;
    } else if (testTitle == 'Тест на тему "Условные операторы"') {
      return ApiData.quizIfOperator;
    } else if (testTitle == 'Тест на тему "Циклы"') {
      return ApiData.quizCycle;
    } else if (testTitle == 'Тест на тему "Строки"') {
      return ApiData.quizStr;
    } else if (testTitle == 'Тест на тему "Списки"') {
      return ApiData.quizList;
    } else if (testTitle == 'Тест на тему "Словари"') {
      return ApiData.quizDictionary;
    } else if (testTitle == 'Тест на тему "Множества"') {
      return ApiData.quizSets;
    } else if (testTitle == 'Тест на тему "Функции"') {
      return ApiData.quizFunction;
    } else if (testTitle == 'Тест на тему "Исключения"') {
      return ApiData.quizExceptions;
    } else if (testTitle == 'Тест на тему "Файлы"') {
      return ApiData.quizFile;
    } else if (testTitle == 'Тест на тему "Модули"') {
      return ApiData.quizModule;
    } else if (testTitle == 'Тест на тему "Регулярные выражения"') {
      return ApiData.quizRegular;
    }
    return null;
  }
}
