import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_digitendance/ui/authentication/state/institution_state.dart';

import '../../app/models/course.dart';
import '../../app/models/pre_reqs.dart';
import '../home/admin/state/admin_state.dart';

final preReqsEditingProvider =
    StateNotifierProvider<PreReqsEditingNotifier, PreReqsEditingState>((ref) {
//TODO  initiate the notifier

//read the institituion for tis user.
  final institution = ref.read(institutionNotifierProvider);

  final allPreReqs = ref.read(allCoursesStreamProvider).value;

  PreReqsEditingState initialState = PreReqsEditingState(
      allPreReqs: Set.from(ref.read(allCoursesStreamProvider).value!.map((e) => e.toPreReq())),
      availablePreReqs: Set.from(ref.read(allCoursesStreamProvider).value!.map((e) => e.toPreReq())));
  // initialState.allPreReqs =
  //     Set.from(ref.read(allCoursesStreamProvider).value!.toList());
  initialState.selectedPreReqs = {};
  PreReqsEditingNotifier notifier = PreReqsEditingNotifier(ref, initialState);

  return notifier;
});

class PreReqsEditingNotifier extends StateNotifier<PreReqsEditingState> {
  PreReqsEditingNotifier(this.ref, state) : super(state);

  final ref;

  void getAllPreReqs() {
    Set<Course> courses = Set.from(ref.read(allCoursesStreamProvider).value);
    for (var element in courses) {
      state.allPreReqs.add(element.toPreReq());
    }
    
  }

  void addPreReq(PreReqs preReq) {
    ///check if the pre req already exists in the [state.selectedPreReqs]
    ///and [state.selectedPreReqs] isnot empty
    if (!(state.selectedPreReqs!.contains(preReq) &&
        state.selectedPreReqs!.isNotEmpty)) {
      state.selectedPreReqs!.add(preReq);

      state.availablePreReqs.remove(preReq);

      state = state.copyWith();
    }
  }

  void removePreReq(PreReqs preReq) {
    if ((state.selectedPreReqs!.contains(preReq) &&
        state.selectedPreReqs!.isNotEmpty)) {
      state.availablePreReqs.add(preReq);

      state.selectedPreReqs?.remove(preReq);

      state = state.copyWith();
    }
  }
}

class PreReqsEditingState extends Equatable {
  PreReqsEditingState(
      {required this.allPreReqs,
      required this.availablePreReqs,
      this.selectedPreReqs})
      : super();

  late Set<PreReqs> allPreReqs;
  late Set<PreReqs> availablePreReqs;
  late Set<PreReqs>? selectedPreReqs = {};

  @override
  // TODO: implement props
  List<Object?> get props => [selectedPreReqs];

  // bool get isModified => (previousPreReqsState != newPreReqsState);
  // // bool get isNotModified => !isModified;

  PreReqsEditingState copyWith({
    Set<PreReqs>? allPreReqs,
    Set<PreReqs>? availablePreReqs,
    Set<PreReqs>? selectedPreReqs,
  }) {
    return PreReqsEditingState(
      allPreReqs: allPreReqs ?? this.allPreReqs,
      availablePreReqs: availablePreReqs ?? this.availablePreReqs,
      selectedPreReqs: selectedPreReqs ?? this.selectedPreReqs,
    );
  }
}
