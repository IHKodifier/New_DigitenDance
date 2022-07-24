import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_digitendance/ui/authentication/state/institution_state.dart';

import '../../app/models/course.dart';
import '../home/admin/state/admin_state.dart';

final preReqsEditingProvider =
    StateNotifierProvider<PreReqsEditingNotifier, PreReqsEditingState>((ref) {
//TODO  initiate the notifier

//read the institituion for tis user.
  final institution = ref.read(institutionNotifierProvider);

  final allPreReqs = ref.read(allCoursesStreamProvider).value;

  PreReqsEditingState initialState = PreReqsEditingState(
      allPreReqs: Set.from(ref.read(allCoursesStreamProvider).value!),
      availablePreReqs: Set.from(ref.read(allCoursesStreamProvider).value!));
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
    state.allPreReqs = Set.from(ref.read(allCoursesStreamProvider).value);
  }

  void addPreReq(Course course) {
    ///check if the pre req already exists in the [state.selectedPreReqs]
    ///and [state.selectedPreReqs] isnot empty
    if (!(state.selectedPreReqs!.contains(course) &&
        state.selectedPreReqs!.isNotEmpty)) {
      state.selectedPreReqs!.add(course);

      state.availablePreReqs.remove(course);

      state = state.copyWith();
    }
  }

  void removePreReq(Course course) {
   if ((state.selectedPreReqs!.contains(course) &&
        state.selectedPreReqs!.isNotEmpty)) {
      state.availablePreReqs.add(course);

      state.selectedPreReqs?.remove(course);

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

  late Set<Course> allPreReqs;

  late Set<Course> availablePreReqs;
  late Set<Course>? selectedPreReqs = {};

  @override
  // TODO: implement props
  List<Object?> get props => [selectedPreReqs];

  // bool get isModified => (previousPreReqsState != newPreReqsState);
  // // bool get isNotModified => !isModified;

  PreReqsEditingState copyWith({
    Set<Course>? allPreReqs,
    Set<Course>? availablePreReqs,
    Set<Course>? selectedPreReqs,
  }) {
    return PreReqsEditingState(
      allPreReqs: allPreReqs ?? this.allPreReqs,
      availablePreReqs: availablePreReqs ?? this.availablePreReqs,
      selectedPreReqs: selectedPreReqs ?? this.selectedPreReqs,
    );
  }
}
