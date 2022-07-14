import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';

import '../../app/models/course.dart';
import '../home/admin/state/admin_state.dart';

final preReqsEditingProvider =
    StateNotifierProvider<PreReqsEditingNotifier, PreReqsEditingState>((ref) {
//TODO  initiate the notifier

//read the institituion for tis user.
  final institution = ref.read(institutionNotifierProvider);

  final allPreReqs = ref.read(allCoursesStreamProvider).value;

  PreReqsEditingState initialState = PreReqsEditingState();
  initialState.allPreReqs =
      Set.from(ref.read(allCoursesStreamProvider).value!.toList());
  PreReqsEditingNotifier notifier = PreReqsEditingNotifier(ref, initialState);

  return notifier;
});

class PreReqsEditingNotifier extends StateNotifier<PreReqsEditingState> {
  PreReqsEditingNotifier(this.ref, state) : super(state);

  final ref;

  
}

class PreReqsEditingState extends Equatable {
  PreReqsEditingState() : super();

  late Set<Course> allPreReqs;
  late Set<Course> availablePreReqs;
  late Set<Course> selctedPreReqs = <Course>{};

  @override
  // TODO: implement props
  List<Object?> get props => [selctedPreReqs];

  // bool get isModified => (previousPreReqsState != newPreReqsState);
  // // bool get isNotModified => !isModified;

  // PreReqsEditingState copy() {
  //   return PreReqsEditingState(previousPreReqsState: previousPreReqsState);
  // }
}
