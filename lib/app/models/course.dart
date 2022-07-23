import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/models/faculty.dart';

import 'package:new_digitendance/app/models/session.dart';

class Course extends Equatable {
  Course({
    required this.courseId,
    required this.courseTitle,
    required this.credits,
    required this.docRef,
    this.preReqs,
    this.sessions,
  });

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  factory Course.fromMap(Map<String, dynamic> map) {
    Course retval = Course(
      courseId: map['courseId'],
      courseTitle: map['courseTitle'],
      credits: map['credits']?.toInt(),
      preReqs: map['preReqs'] != null
          ? List<Course>.from(map['preReqs']?.map((x) => Course.fromMap(x)))
          : null,
      sessions: map['sessions'] != null
          ? List<Session>.from(map['sessions']?.map((x) => Session.fromMap(x)))
          : null,
      docRef: map['docRef'],
    );
    return retval;
  }

  String courseId;
  String courseTitle;
  int credits;
  DocumentReference docRef;
  Faculty? faculty = Faculty.initial();
  List<Course>? preReqs = [];
  List<Session>? sessions = [];

  @override
  List<Object> get props {
    return [
      courseId,
      courseTitle,
      credits,
      preReqs ?? <Course>[],
      sessions ?? <Session>[],
      docRef.path
    ];
  }

  @override
  String toString() {
    return 'Course(courseId: $courseId, courseTitle: $courseTitle, credits: $credits, preReqs: $preReqs, sessions: $sessions, docRef: ${docRef.path})';
  }

  static Course initial() {
    return Course(
        courseId: 'not Initialized',
        courseTitle: 'not Initialized',
        credits: 0,
        docRef: DbApi().documentReferenceFromPath('institutions/default'));
  }

  Course copyWith({
    String? courseId,
    String? courseTitle,
    int? credits,
    List<Course>? preReqs,
    List<Session>? sessions,
    DocumentReference? docRef,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      credits: credits ?? this.credits,
      preReqs: preReqs ?? this.preReqs,
      sessions: sessions ?? this.sessions,
      docRef: docRef!,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (courseId != null) {
      result.addAll({'courseId': courseId});
    }
    if (courseTitle != null) {
      result.addAll({'courseTitle': courseTitle});
    }
    if (credits != null) {
      result.addAll({'credits': credits});
    }
    if (preReqs != null) {
      result.addAll({'preReqs': preReqs!.map((x) => x.toMap()).toList()});
    }
    if (sessions != null) {
      result.addAll({'sessions': sessions!.map((x) => x.toMap()).toList()});
    }
    if (docRef != null) {
      result.addAll({'docRef': this.docRef.path});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
