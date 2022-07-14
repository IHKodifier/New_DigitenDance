import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  Future<DocumentReference> addNewCourse({required Course course, required ProviderRef ref}) {
    ///TODO add institutionalized scope saving
    // final institution =
    log.d('Adding new course to DB ${course.toString()}');

    return FirebaseFirestore.instance
        .collection('courses')
        .add(course.toMap())
        .then((value) => value);
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
