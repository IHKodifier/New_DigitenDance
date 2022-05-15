import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import '../../../../app/models/course.dart';
import '../../../authentication/state/institution_state.dart';

final adminStateNotifierProvider =
    StateNotifierProvider<AdminStateNotifier, AdminState>((ref) {
  return AdminStateNotifier(ref);
});

/// provides encapsulated state of []
class AdminState extends Equatable {
  Course? activeCourse;
    AsyncValue<List<Course>>? availableCourses;
  bool isBusy = false;

  @override
  // TODO: implement props
  List<Object?> get props => [availableCourses, activeCourse, isBusy];
}

class AdminStateNotifier extends StateNotifier<AdminState> {
  AdminStateNotifier(this.ref, [state]) : super(state ?? AdminState());

  late FirebaseFirestore db;
  final StateNotifierProviderRef<AdminStateNotifier, AdminState> ref;
  bool get isBusy => state.isBusy;
  bool get isNOtBusy => state.isBusy;
  set busy(bool val) {
    state.isBusy = val;
  }


  Stream<Course>  availableCourses (){
    db = ref.read(dbProvider);
    String institutionDocRef = ref.read(institutionNotifierProvider).docRef.path;

    final stream = db.doc(institutionDocRef).collection('courses').snapshots();
    return stream.map((querySnapshot) => Course.fromMap(querySnapshot.docs[0].data()));
  }
}
