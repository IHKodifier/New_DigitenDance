import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/models/pre_reqs.dart';

import 'package:new_digitendance/app/models/session.dart';

class Course extends Equatable {
  Course({
    required this.id,
    required this.title,
    required this.credits,
    required this.docRef,
    this.preReqs,
    this.sessions,
  });

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  factory Course.fromMap(Map<String, dynamic> map) {
    Course retval =      Course(
      id: map['courseId'],
      title: map['courseTitle'],
      credits: map['credits']?.toInt(),
      preReqs: map['preReqs'] != null
          ? List<PreReqs>.from(map['preReqs']?.map((x) => PreReqs.fromMap(x)))
          : null,
      sessions: map['sessions'] != null
          ? List<Session>.from(map['sessions']?.map((x) => Session.fromMap(x)))
          : null,
      docRef: DbApi().documentReferenceFromStringPath(map['docRef']),
    );
    return retval;
  }

  int credits;
  DocumentReference<Map<String, dynamic>>  docRef;
  String id;
  List<PreReqs?>? preReqs = [];
  List<Session?>? sessions = [];
  String title;

  @override
  List<Object> get props {
    return [
      id,
      title,
      credits,
      preReqs ?? <PreReqs>[],
      sessions ?? <Session>[],
      docRef.path
    ];
  }

  @override
  String toString() {
    return 'Course(courseId: $id, courseTitle: $title, credits: $credits, preReqs: ${preReqs ?? ''}, sessions: $sessions, docRef: ${docRef.path})';
  }

  static Course initial() {
    return Course(
        id: 'not Initialized',
        title: 'not Initialized',
        credits: 0,
        docRef: DbApi().documentReferenceFromStringPath('institutions/default'),
        preReqs: const <PreReqs>[],
        sessions: const <Session>[]);
  }

  Course copyWith({
    String? courseId,
    String? courseTitle,
    int? credits,
    List<PreReqs>? preReqs,
    List<Session>? sessions,
   DocumentReference<Map<String, dynamic>>?  docRef,
  }) {
    return Course(
      id: courseId ?? id,
      title: courseTitle ?? title,
      credits: credits ?? this.credits,
      preReqs: preReqs ?? this.preReqs,
      sessions: sessions ?? this.sessions,
      docRef: docRef ?? this.docRef,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'courseId': id});
    result.addAll({'courseTitle': title});
    result.addAll({'credits': credits});
    if (preReqs != null) {
      result.addAll({'preReqs': preReqs!.map((x) => x?.toMap()).toList()});
    }
    if (sessions != null) {
      result.addAll({'sessions': sessions!.map((x) => x?.toMap()).toList()});
    }
    result.addAll({'docRef': docRef.path});

    return result;
  }

/// toShallowMap does not return deeply nested collections to facilate  writing top level document to the forestore
  Map<String, dynamic> toShallowMap() {
    final result = <String, dynamic>{};

    result.addAll({'courseId': id});
    result.addAll({'courseTitle': title});
    result.addAll({'credits': credits});
    if (preReqs != null) {
      result.addAll({'preReqs': preReqs!.map((x) => x?.toMap()).toList()});
    }
  
      result.addAll({'sessions': <Session>[]});
    
    result.addAll({'docRef': docRef.path});

    return result;
  }

  String toJson() => json.encode(toMap());

  PreReqs toPreReq() => PreReqs(id: id, title: title, credits: credits);
}
