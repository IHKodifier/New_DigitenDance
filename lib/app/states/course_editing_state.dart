import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/course.dart';

///[courseEditingProvider] provides inatance of currently EDITED [Course] managedg by [CourseEditingNotifier]
final courseEditingProvider =
    StateNotifierProvider<CourseEditingNotifier, Course>((ref) {
  return CourseEditingNotifier(Course(), ref);
});


class CourseEditingNotifier extends StateNotifier<Course> {
  final StateNotifierProviderRef<CourseEditingNotifier, Course> ref;
  CourseEditingNotifier(state, this.ref) : super(state);
  DocumentReference? get docRef => state.docRef;

 

  Course cloneFrom(Course source) => source.copyWith();
  void setCourseEditingState(Course source) {
    state = source;
  }

  void nullify() {
    state = state.copyWith();
    state.id = '';
    state.title = '';
    state.credits = 0;
    state.docRef = null;
    state.preReqs = [];
    state.sessions = [];
  }
}
