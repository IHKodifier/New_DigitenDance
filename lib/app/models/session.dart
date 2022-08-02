import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/course.dart';

import 'package:new_digitendance/app/models/course_registration.dart';
import 'package:new_digitendance/app/models/faculty.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';

class Session extends Equatable {
  Session({
    this.sessionId,
    this.sessionTitle,
    required this.courseId,
    this.registrationStartDate,
    this.registrationEndDate,
    this.faculty,
    this.courseRegistrations,
  });

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      sessionId: map['sessionId'],
      sessionTitle: map['sessionTitle'],
      courseId: map['parentCourseId'] ?? '',
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

  List<CourseRegistration>? courseRegistrations;
  Faculty? faculty;
  String courseId;
  Timestamp? registrationEndDate;
  DateTime? registrationStartDate;
  String? sessionId;
  SessionStatus? sessionStatus;
  String? sessionTitle;

  @override
  List<Object> get props {
    return [
      // sessionId ?? '',
      sessionTitle ?? '',
      // parentCourseId,
      // registrationStartDate!,
      // registrationEndDate!,
      // faculty!,
      // courseRegistrations ?? <CourseRegistration>[],
    ];
  }

  Session copyWith({
    String? id,
    String? title,
    String? parentCourseId,
    DateTime? registrationStartDate,
    Timestamp? registrationEndDate,
    Faculty? faculty,
    List<CourseRegistration>? courseRegistrations,
  }) {
    return Session(
      sessionId: id ?? sessionId,
      sessionTitle: title ?? sessionTitle,
      courseId: parentCourseId ?? courseId,
      registrationStartDate:
          registrationStartDate ?? this.registrationStartDate,
      registrationEndDate: registrationEndDate ?? this.registrationEndDate,
      faculty: faculty ?? this.faculty,
      courseRegistrations: courseRegistrations ?? this.courseRegistrations,
    );
  }

  static Session initial() {
    var session = Session(courseId: Course.initial().id);
    session.courseRegistrations = [CourseRegistration.initial()];
    session.faculty = Faculty.initial();
    session.registrationEndDate = Timestamp.now();
    session.registrationStartDate = DateTime.now();
    session.sessionStatus = SessionStatus.inProgress;
    session.sessionTitle = 'title not initialized';
    session.sessionId = 'id not initialized';
    return session;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (sessionId != null) {
      result.addAll({'sessionId': sessionId});
    }
    if (sessionTitle != null) {
      result.addAll({'sessionTitle': sessionTitle});
    }
    result.addAll({'parentCourseId': courseId});
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

  String toJson() => json.encode(toMap());
}

enum RegistrationStatus {
  registrationOpened,
  registrationClosed,
}

enum SessionStatus {
  closed,
  inProgress,
}
