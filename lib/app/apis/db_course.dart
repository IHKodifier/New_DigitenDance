import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/apis/db_session.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';

import '../models/course.dart';
import 'dbapi.dart';

class DbCourse {
  /// fnnction to add a new Course doc at path characterized by
  /// users [Institution] and currentlySelected[Course]
  ///
  Logger log = Logger();

  ///
  Future<void> addNewCourse(
      {required Course course, required WidgetRef ref}) {
    ///get current [Institution]
    final institution = ref.read(institutionNotifierProvider).value;
    log.d(
        'Adding new course ${course.id}to  Instution Id ${institution?.id} \n at path ${institution?.docRef?.path}');

    ///save the course to DB
    ///
    ///create batchwrite
    WriteBatch writeBatch = ref.read(dbProvider).batch();

    ///update course docRef to actual
    var _docRef = ref.read(dbApiProvider).dbCourse.getDocRefForNewCourse(ref);
    course.docRef = _docRef;

    //add all sessions to batch

    course.sessions?.forEach((element) {
      writeBatch.set(
          course.docRef.collection('sessions').doc(), element?.toMap());
    });
    writeBatch.set(course.docRef, course.toShallowMap());

    return writeBatch.commit();
    // return FirebaseFirestore.instance
    //     .doc(_docRef.path)
    //     .set(course.toMap())
    //     .then((value) => _docRef);
  }

  DocumentReference<Map<String, dynamic>> getDocRefForNewCourse(WidgetRef ref) {
    var docref = ref
        .read(dbProvider)
        .doc(ref.read(institutionNotifierProvider).value!.docRef!.path)
        .collection('courses')
        .doc();
    return docref;
  }
}
