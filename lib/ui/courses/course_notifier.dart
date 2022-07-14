import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../app/apis/app_services.dart';
import '../../app/models/course.dart';

class CourseNotifier extends StateNotifier<Course> {
  CourseNotifier(state, this.ref) : super(state?? Course(docRef: AppServices.dbService.documentReferenceFromPath('institutions/intial'), courseId: '', courseTitle: '', credits: 21));

  var logger = Logger(printer: PrettyPrinter());
  final StateNotifierProviderRef<CourseNotifier, Course> ref;

  DocumentReference? get docRef => state.docRef;

  void setSessiononCourseProvider(
      QuerySnapshot<Map<String, dynamic>> data, String courseId) {
    state.sessions!.clear();
    // var courseId = ref.read(currentCourseProvider).courseId!;
    for (var element in data.docs) {
      // Utilities.log(element.data().toString());

      // state.sessions!
      //     .add(Session.fromDataAndCourseId(element.data(), courseId));

      logger.i(
          'ADDED  ${element.data()['sessionId'] + element.data()['facultyId']} to selected Course\'s SESSIONS ');
    }
  }

  // void removePreReq(Course courseElement) {
  //   final newState = state.copyWith();
  //   if (newState.preReqs!.isNotEmpty) {
  //     if (newState.preReqs!.contains(courseElement)) {
  //       newState.preReqs!.remove(courseElement);
  //     }
  //     state = newState;
  //   }
  // }

  void setSelectedCourse(Course course) {
    state = course;
  }
}
