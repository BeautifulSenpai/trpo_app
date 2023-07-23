class Student {
  final int id;
  final int studentId;
  final String status;

  Student({required this.id, required this.studentId, required this.status});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      studentId: json['student_id'],
      status: json['status'],
    );
  }
}
