import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:new_digitendance/app/models/course_registration.dart';
import 'package:new_digitendance/app/models/faculty.dart';

class Session extends Equatable {
  String? sessionId;
  String? sessionTitle;
  String parentCourseId;
  DateTime? registrationStartDate;
  Timestamp? registrationEndDate;
  SessionStatus? sessionStatus;
  Faculty? faculty;
  List<CourseRegistration>? courseRegistrations;
  Session({
    this.sessionId,
    this.sessionTitle,
    required this.parentCourseId,
    this.registrationStartDate,
    this.registrationEndDate,
    this.faculty,
    this.courseRegistrations,
  });

  Session copyWith({
    String? sessionId,
    String? sessionTitle,
    String? parentCourseId,
    DateTime? registrationStartDate,
    Timestamp? registrationEndDate,
    Faculty? faculty,
    List<CourseRegistration>? courseRegistrations,
  }) {
    return Session(
      sessionId: sessionId ?? this.sessionId,
      sessionTitle: sessionTitle ?? this.sessionTitle,
      parentCourseId: parentCourseId ?? this.parentCourseId,
      registrationStartDate:
          registrationStartDate ?? this.registrationStartDate,
      registrationEndDate: registrationEndDate ?? this.registrationEndDate,
      faculty: faculty ?? this.faculty,
      courseRegistrations: courseRegistrations ?? this.courseRegistrations,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (sessionId != null) {
      result.addAll({'sessionId': sessionId});
    }
    if (sessionTitle != null) {
      result.addAll({'sessionTitle': sessionTitle});
    }
    result.addAll({'parentCourseId': parentCourseId});
    if (registrationStartDate != null) {
      result.addAll({
        'registrationStartDate': registrationStartDate!.millisecondsSinceEpoch
      });
    }
    if (registrationEndDate != null) {
      result.addAll({'registrationEndDate': registrationEndDate!});
    }
    if (faculty != null) {
      result.addAll({'faculty': faculty!.toMap()});
    }
    if (courseRegistrations != null) {
      result.addAll({
        'courseRegistrations':
            courseRegistrations!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      sessionId: map['sessionId'],
      sessionTitle: map['sessionTitle'],
      parentCourseId: map['parentCourseId'] ?? '',
      registrationStartDate: map['registrationStartDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['registrationStartDate'])
          : null,
      registrationEndDate:
          map['registrationEndDate']! ?? map['registrationEndDate'].toDate(),
      faculty: map['faculty'] != null ? Faculty.fromMap(map['faculty']) : null,
      courseRegistrations: map['courseRegistrations'] != null
          ? List<CourseRegistration>.from(map['courseRegistrations']
              ?.map((x) => CourseRegistration.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      sessionId ?? '',
      sessionTitle ?? '',
      parentCourseId,
      registrationStartDate!,
      registrationEndDate!,
      faculty!,
      courseRegistrations ?? <CourseRegistration>[],
    ];
  }
}

enum RegistrationStatus {
  registrationOpened,
  registrationClosed,
}
enum SessionStatus {
  closed,
  inProgress,
}
