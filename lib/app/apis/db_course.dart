import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';

import '../models/course.dart';
import 'dbapi.dart';

class DbCourse {
  /// fnnction to add a new Course doc at path characterized by
  /// users [Institution] and currentlySelected[Course]
  ///
  Logger log = Logger();

  ///
  FutureOr<DocumentReference> addNewCourse(
      {required Course course, required WidgetRef ref}) {
    ///get current [Institution]
    final institution = ref.read(institutionNotifierProvider).value;
    log.d(
        'Adding new course ${course.toString()}to  Instution Id ${institution?.docRef?.id} ');

    ///save the course to DB
    ///update course docRef to actual
    var _docRef = ref
        .read(dbApiProvider)
        .dbCourse
        .getDocRefForNewCourse(ref as ProviderRef<dynamic>);
    course.docRef = _docRef;

    return FirebaseFirestore.instance
// .collection('institutions')
        .doc(institution!.docRef!.path)
        .collection('courses')
        .add(course.toMap())
        .then((value) {
      log.d('${course.id} successfully written to ${value.path.toString()}');

      return value;
    });
  }

  DocumentReference<Map<String, dynamic>> getDocRefForNewCourse(
      ProviderRef ref) {
    var docref = ref
        .read(dbProvider)
        .doc(ref.read(institutionNotifierProvider).value!.docRef!.path)
        .collection('courses')
        .doc();
    return docref;
  }
}
