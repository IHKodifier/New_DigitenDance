import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/models/course.dart';

final adminStateNotifierProvider =
    StateNotifierProvider<AdminStateNotifier, AdminState>((ref) {
  return AdminStateNotifier(AdminState());
});

/// provides encapsulated state of []
class AdminState {
  List<Course>? availableCourses;
}

class AdminStateNotifier extends StateNotifier<AdminState> {
  AdminStateNotifier(AdminState state) : super(state);
}
