import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:new_digitendance/app/models/course_registration.dart';
import 'package:new_digitendance/app/models/faculty.dart';

class Session extends Equatable {
  Session({
    this.id,
    this.title,
    // required this.courseId,
    this.registrationStartDate,
    this.registrationEndDate,
    this.faculty,
    this.courseRegistrations,
  });

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      title: map['title'],
      // courseId: map['parentCourseId'] ?? '',
      registrationStartDate: map['registrationStartDate'] != null
          ? (map['registrationStartDate'] as Timestamp)
          : null,
      registrationEndDate:
          map['registrationEndDate']! ?? (map['registrationEndDate']as Timestamp).toDate(),
      faculty: map['faculty'] != null ? Faculty.fromMap(map['faculty']) : null,
      courseRegistrations: map['courseRegistrations'] != null
          ? List<Registration>.from(map['courseRegistrations']
              ?.map((x) => Registration.fromMap(x)))
          : null,
    );
  }

  List<Registration>? courseRegistrations;
  Faculty? faculty;
  Timestamp? registrationEndDate;

  Timestamp? registrationStartDate;
  String? id;
  SessionStatus? sessionStatus;
  String? title;

  @override
  List<Object> get props {
    return [
      // id ?? '',
      title ?? '',
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
    Timestamp? registrationStartDate,
    Timestamp? registrationEndDate,
    Faculty? faculty,
    List<Registration>? courseRegistrations,
  }) {
    return Session(
      id: id ?? id,
      title: title ?? title,
      // courseId: parentCourseId ?? courseId,
      registrationStartDate:
          registrationStartDate ?? this.registrationStartDate as Timestamp,
      registrationEndDate: registrationEndDate ?? this.registrationEndDate,
      faculty: faculty ?? this.faculty,
      courseRegistrations: courseRegistrations ?? this.courseRegistrations,
    );
  }

  static Session initial() {
    var session = Session();
    session.courseRegistrations = [Registration.initial()];
    session.faculty = Faculty.initial();
    session.registrationEndDate = Timestamp.now();
    session.registrationStartDate = Timestamp.now();
    session.sessionStatus = SessionStatus.inProgress;
    session.title = 'title not initialized';
    session.id = 'id not initialized';
    return session;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    // result.addAll({'parentCourseId': courseId});
    if (registrationStartDate != null) {
      result.addAll({
        'registrationStartDate': registrationStartDate
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
