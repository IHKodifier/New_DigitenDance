import 'dart:convert';

import 'package:equatable/equatable.dart';

class CourseRegistration extends Equatable {
  final String studentId;
  final DateTime registrationDate;
  CourseRegistration({
    required this.studentId,
    required this.registrationDate,
  });
  static CourseRegistration initial() {
    var registration = CourseRegistration(
        studentId: 'not initialized', registrationDate: DateTime.now());
    return registration;
  }

  CourseRegistration copyWith({
    String? studentId,
    DateTime? registrationDate,
  }) {
    return CourseRegistration(
      studentId: studentId ?? this.studentId,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'studentId': studentId});
    result
        .addAll({'registrationDate': registrationDate.millisecondsSinceEpoch});

    return result;
  }

  factory CourseRegistration.fromMap(Map<String, dynamic> map) {
    return CourseRegistration(
      studentId: map['studentId'] ?? '',
      registrationDate:
          DateTime.fromMillisecondsSinceEpoch(map['registrationDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseRegistration.fromJson(String source) =>
      CourseRegistration.fromMap(json.decode(source));

  @override
  String toString() =>
      'CourseRegistration(studentId: $studentId, registrationDate: $registrationDate)';

  @override
  List<Object> get props => [studentId, registrationDate];
}
