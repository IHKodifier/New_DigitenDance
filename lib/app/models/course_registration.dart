import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Registration extends Equatable {
  final String id;final String studentId;
  final Timestamp registrationDate;
  const Registration( {required this.id,
    required this.studentId,
    required this.registrationDate,
  });
  static Registration initial() {
    var registration = Registration(
        studentId: 'not initialized', registrationDate: Timestamp.now(), id: 'not initialized' );
    return registration;
  }

  Registration copyWith({
    String? id,
    String? studentId,
    Timestamp? registrationDate,
  }) {
    return Registration(
      id: id??this.id,
      studentId: studentId ?? this.studentId,
      registrationDate: registrationDate?? Timestamp.now()
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id':id});

    result.addAll({'studentId': studentId});
    result
        .addAll({'registrationDate': registrationDate});

    return result;
  }

  factory Registration.fromMap(Map<String, dynamic> map) {
    return Registration(
      id: map['id'],
      studentId: map['studentId'] ?? '',
      registrationDate:
          (map['registrationDate'])as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Registration.fromJson(String source) =>
      Registration.fromMap(json.decode(source));

  @override
  String toString() =>
      'CourseRegistration(studentId: $studentId, registrationDate: $registrationDate)';

  @override
  List<Object> get props => [id,studentId, registrationDate];
}
