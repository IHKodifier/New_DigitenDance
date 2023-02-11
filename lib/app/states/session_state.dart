import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/states/admin_state.dart';
import '../../app/apis/db_session.dart';
import '../../app/apis/db_session.dart';
import '../../app/models/session.dart';
import '../models/faculty.dart';

final sessionStreamProvider = StreamProvider<List<Session>>((ref)  {
 return SessionGrabber(ref).stream;
//
});

class SessionGrabber {
  SessionGrabber(this.ref){
    var currentCourse = ref.watch(currentCourseProvider);
    Session session;
    final firebaseStream = ref
      .read(dbProvider)
      .doc(currentCourse.docRef!.path)
      .collection('sessions')
      .snapshots();
      final subscription = firebaseStream
      .listen(
    (event) async {
      for (var doc in event.docs) {
        session = Session.fromMap(doc.data());
        final faculty = await DbSession().getFacultybyUserId(session, ref);
        session.faculty = faculty;
        sessions.add(session);
      }

  _controller.sink.add(sessions);
    },
  );
        // ref.read(currentCourseProvider.notifier).attachSessionsToCourse(sessions);
  }

  final StreamProviderRef ref;
    List<Session> sessions=<Session>[];

  final _controller= StreamController<List<Session>>();

void refrehSessions(){
  Session session;
 ref
      .read(dbProvider)
      .doc(ref.read(currentCourseProvider).docRef!.path)
      .collection('sessions')
      .snapshots().listen((event) async  {
  for (var doc in event.docs) {
        session = Session.fromMap(doc.data());
        final faculty = await DbSession().getFacultybyUserId(session, ref);
        session.faculty = faculty;
        sessions.add(session);
      }
       _controller.sink.add(sessions);




       });

}

  Stream<List<Session>> get stream=>_controller.stream;
}


final newSessionNotifierProvider =
    StateNotifierProvider<SessionNotifier, Session>((ref) {
  return SessionNotifier(Session());
});

class SessionNotifier extends StateNotifier<Session> {
  SessionNotifier(state) : super(state);

  void setSession(Session session) {
    state = session.copyWith();
  }

  void setFaculty(Faculty value) {
    state.faculty = value;
    state = state.copyWith();
  }

  void nullify() {
    // dispose();
  }
}