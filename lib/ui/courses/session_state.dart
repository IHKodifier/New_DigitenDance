import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

import '../../app/models/course.dart';
import '../../app/models/session.dart';
import '../authentication/state/institution_state.dart';
import '../home/admin/state/admin_state.dart';
import '../home/admin/state/transformer.dart';

final sessionStreamProvider = StreamProvider<List<Session>>((ref) async* {
  var docRef = ref.watch(currentCourseProvider).docRef;
  var sessionFireStream = ref
      .read(dbProvider)
      .doc(docRef.path)
      .collection('sessions')
      .snapshots()
      .transform(streamTransformer(Session.fromMap));
  yield* sessionFireStream;
});







class SessionNotifier extends StateNotifier<Session> {
  SessionNotifier(this.ref) : super( Session.initial());

  final StateNotifierProviderRef<SessionNotifier,Session> ref;

  void setCurentSessionState(Session session) {
    state = session;
    // ref.read(currentCourseProvider.notifier).;
  }
}

/// [currentSessionProvider] provides the currently selected [Session] of [Course] provided by [currentCourseProvider]  for the current operation

final currentSessionProvider =
    StateNotifierProvider<SessionNotifier, Session>((ref) {
  return SessionNotifier(ref);
});
