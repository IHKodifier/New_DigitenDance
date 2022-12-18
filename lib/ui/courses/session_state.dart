import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import '../../app/apis/db_session.dart';
import '../../app/apis/db_session.dart';
import '../../app/models/session.dart';

final sessionStreamProvider = StreamProvider<List<Session>>((ref)  {
 return SessionGrabber(ref).stream;
//
});

class SessionGrabber {
  SessionGrabber(this.ref){
    List<Session> sessions=<Session>[];

    final firebaseStream = ref
      .read(dbProvider)
      .doc(ref.read(currentCourseProvider).docRef.path)
      .collection('sessions')
      .snapshots();
 Session session;
      final subscription = firebaseStream.listen(
    // ignore: void_checks
    (event) async {
      for (var doc in event.docs) {
        session = Session.fromMap(doc.data());
        final faculty = await DbSession().getFacultybyUserId(session, ref);
        session.faculty = faculty;
        sessions.add(session);

  // yield session;
  _controller.sink.add(sessions);
      }
    },
  );
  }

  final StreamProviderRef ref;

  final _controller= StreamController<List<Session>>();

  Stream<List<Session>> get stream=>_controller.stream;
}