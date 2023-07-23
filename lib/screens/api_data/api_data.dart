class ApiData {
  static const String quizSyntax = 'http://62.217.182.138:3000/quizsyntax';
  static const String quizTypeObject =
      'http://62.217.182.138:3000/quiztypeobject';
  static const String quizTypeOperator =
      'http://62.217.182.138:3000/quiztypeoperator';
  static const String quizIfOperator =
      'http://62.217.182.138:3000/quizifoperator';
  static const String quizCycle = 'http://62.217.182.138:3000/quizcycle';
  static const String quizStr = 'http://62.217.182.138:3000/quizstr';
  static const String quizList = 'http://62.217.182.138:3000/quizlist';
  static const String quizDictionary =
      'http://62.217.182.138:3000/quizdictionary';
  static const String quizSets = 'http://62.217.182.138:3000/quizsets';
  static const String quizFunction = 'http://62.217.182.138:3000/quizfunction';
  static const String quizExceptions =
      'http://62.217.182.138:3000/quizexceptions';
  static const String quizFile = 'http://62.217.182.138:3000/quizfile';
  static const String quizModule = 'http://62.217.182.138:3000/quizmodule';
  static const String quizRegular = 'http://62.217.182.138:3000/quizregular';

  static const String practiceUrl =
      'https://www.programiz.com/python-programming/online-compiler/';
  static const String requestUrl = 'http://62.217.182.138:3000/request';
  static const String loginUrl = 'http://62.217.182.138:3000/login';
  static const String adminRequests =
      'http://62.217.182.138:3000/admin/requests';
  static const String deleteStudent = 'http://62.217.182.138:3000/students';
  static const String approvedStudents =
      'http://62.217.182.138:3000/approved_students';
  static const String lectureScreen = 'http://62.217.182.138:3000/lectures';
  static const String testScreen = 'http://62.217.182.138:3000/tests';
  static const String addLecture = 'http://62.217.182.138:3000/addLecture';
  static String approveRequest(int requestId) =>
      'http://62.217.182.138:3000/admin/requests/$requestId/approve';
  static String rejectRequest(int requestId) =>
      'http://62.217.182.138:3000/admin/requests/$requestId/reject';
  static String editLecture(int lectureId) =>
      'http://62.217.182.138:3000/lectures/$lectureId';
  static String deleteLecture(int lectureId) =>
      'http://62.217.182.138:3000/lectures/$lectureId';
}
