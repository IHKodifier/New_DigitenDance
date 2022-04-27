import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/db_course.dart';
import 'package:new_digitendance/app/utilities.dart';

import '../../../../app/models/course.dart';
import '../../../authentication/state/institution_state.dart';

final adminStateNotifierProvider =
    StateNotifierProvider<AdminStateNotifier, AdminState>((ref) {
  return AdminStateNotifier(AdminState(), ref);
});

/// provides encapsulated state of []
class AdminState extends Equatable {
  bool isBusy = false;
  List<Course>? availableCourses;
  Course? activeCourse;

  @override
  // TODO: implement props
  List<Object?> get props => [availableCourses, activeCourse, isBusy];
}

class AdminStateNotifier extends StateNotifier<AdminState> {
  final StateNotifierProviderRef<AdminStateNotifier, AdminState> ref;
  AdminStateNotifier(AdminState state, this.ref) : super(state);
  bool get isBusy => state.isBusy;
  set busy(bool val) {
    state.isBusy = val;
  }

  StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<Course Function(String source)>> availableCourses() {
    final institutionDocRef = ref.read(institutionProvider).docRef;
    final stream = FirebaseFirestore.instance
        .doc(institutionDocRef.path)
        .collection('courses')
        .snapshots();

    return Utils.streamTransformer((json) => Course.fromJson);
  }
}
