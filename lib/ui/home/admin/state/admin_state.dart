import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import 'package:new_digitendance/ui/home/admin/state/transformer.dart';
import '../../../../app/models/course.dart';
import '../../../authentication/state/institution_state.dart';

var logger = Logger(printer: PrettyPrinter());
final allCoursesStreamProvider = StreamProvider<List<Course>>((ref) async* {
  // StreamController<QuerySnapshot<Map<String, dynamic>>>
  if (ref.read(institutionNotifierProvider).value?.docRef == null) {
    throw Exception('Institution Doc Ref is null');
  }
  var fireStream = ref
      .read(dbProvider)
      .doc(ref.read(institutionNotifierProvider).value!.docRef!.path)
      .collection('courses')
      .snapshots()
      .transform(streamTransformer(Course.fromMap));
  yield* fireStream;





  

  //////////////////////////////////
  // logger.d(ref.read(institutionNotifierProvider).docRef.path);
  // await ref
  //     .read(dbProvider)
  //     .doc(ref.read(institutionNotifierProvider).docRef.path)
  //     .collection('courses')
  //     .snapshots()
  //     .map((snapshot) async* {
  //   logger
  //       .i('snapshot has ${snapshot.docs.length.toString()} documents inside');
  //   snapshot.docs.map((e) async* {
  //     logger.i('Course Received....${e.data().toString()}');
  //     yield Course.fromMap(e.data());
  //   });
  // });

  // .map((event) => event.docs
  //     .map(
  //       (e) => Course.fromMap(e.data()),
  //     )
  // );
});

final currentCourseProvider =
    StateNotifierProvider<CourseNotifier, Course>((ref) {
  DocumentReference docRef =
      ref.read(dbApiProvider).documentReferenceFromPath('/instiution/default');
  return CourseNotifier(Course(docRef: docRef, courseTitle: '', courseId: '', credits: 0), ref);
});

class CourseNotifier extends StateNotifier<Course> {
  CourseNotifier(state, this.ref) : super(state);

  var logger = Logger(printer: PrettyPrinter());
  final StateNotifierProviderRef<CourseNotifier, Course> ref;

  DocumentReference? get docRef => state.docRef;

  // void setPreReqsonCourse(QuerySnapshot<Map<String, dynamic>> data) {
  //   data.docs.forEach((element) {
  //     state.preReqs!.add(Course.fromData(element.data()));
  //    logger.i(
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
}
