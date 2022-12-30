import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/app/states/institution_state.dart';
import 'package:new_digitendance/app/utilities/transformer.dart';
import '../../../../app/models/course.dart';
import '../models/session.dart';

var log = Logger(printer: PrettyPrinter());



/// [allCoursesStreamProvider] provides a stream of all courses in the current users [Institution]
final allCoursesStreamProvider = StreamProvider<List<Course>>((ref) async* {
  /// get the [Institution] for the current user

  if (ref.read(institutionNotifierProvider).value?.docRef == null) {
    throw Exception('Institution Doc Ref is null');
  }
  log.d(
      'reading stream for ${ref.read(institutionNotifierProvider).value?.docRef?.id}');
  var fireStream = ref
      .read(dbProvider)
      .doc(ref.read(institutionNotifierProvider).value!.docRef!.path)
      .collection('courses')
      .snapshots()
      .transform(streamTransformer(Course.fromMap));

  yield* fireStream;
});




///-[currentCourseProvider] provides the currently selected [Course] for the current operation
final currentCourseProvider =
    StateNotifierProvider<CourseNotifier, Course>((ref) {
  return CourseNotifier(ref);
});

class CourseNotifier extends StateNotifier<Course> {
  CourseNotifier(this.ref) : super(Course.initial());

  var log = Logger(printer: PrettyPrinter());
  final StateNotifierProviderRef<CourseNotifier, Course> ref;

  DocumentReference? get docRef => state.docRef;

  // void setPreReqsonCourse(QuerySnapshot<Map<String, dynamic>> data) {
  //   data.docs.forEach((element) {
  //     state.preReqs!.add(Course.fromData(element.data()));
  //    logger.i(
  //         'added ${element.data().toString()} to selected Course\'s preREQs ');
  //   });
  // }
  void setCurrentCourse(Course course) => state = course;


void setSessionsOnCourse(List <Session> sessions){
  state.sessions=sessions;
  
}


}
