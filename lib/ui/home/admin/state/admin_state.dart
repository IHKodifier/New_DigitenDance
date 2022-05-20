import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/app/models/session.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import '../../../../app/models/course.dart';
import '../../../../app/utilities.dart';
import '../../../authentication/state/institution_state.dart';

final allCoursesStreamProvider =
    StreamProvider<Iterable<Course>>((ref) async* {
  yield*  ref
      .read(dbProvider)
      .doc(ref.read(institutionNotifierProvider).docRef.path)
      .collection('courses')
      .snapshots().map((event) =>
       event.docs.map((e) => Course.fromMap(e.data()),).toList()).asBroadcastStream();
});

final currentCourseProvider =
    StateNotifierProvider<CourseNotifier, Course>((ref) {
  DocumentReference docRef=ref.read(dbApiProvider).documentReferenceFromPath('/instiution/default');
  return CourseNotifier(Course(docRef: docRef), ref);
});

class CourseNotifier extends StateNotifier<Course> {
  final StateNotifierProviderRef<CourseNotifier, Course> ref;
  CourseNotifier(state, this.ref) : super(state);
  DocumentReference? get docRef => state.docRef;

  // void setPreReqsonCourse(QuerySnapshot<Map<String, dynamic>> data) {
  //   data.docs.forEach((element) {
  //     state.preReqs!.add(Course.fromData(element.data()));
  //     Utils.log(
  //         'added ${element.data().toString()} to selected Course\'s preREQs ');
  //   });
  // }

  void setSessiononCourseProvider(
      QuerySnapshot<Map<String, dynamic>> data, String courseId) {
    state.sessions!.clear();
    // var courseId = ref.read(currentCourseProvider).courseId!;
    for (var element in data.docs) {
      // Utilities.log(element.data().toString());

      // state.sessions!
      //     .add(Session.fromDataAndCourseId(element.data(), courseId));

      Utils.log(
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
}
