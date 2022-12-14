import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import '../../app/apis/db_session.dart';
import '../../app/apis/db_session.dart';
import '../../app/models/session.dart';

final sessionStreamProvider = StreamProvider<Session>((ref) async* {
  final _controller = StreamController<Session>();
  final firebaseStream = ref
      .read(dbProvider)
      .doc(ref.read(currentCourseProvider).docRef.path)
      .collection('sessions')
      .snapshots();

  final subscription = firebaseStream.listen((event) {
    print('eventevent event');
  }, onError: _handleError, onDone: _handleDone);
});

//  final session = Session.fromMap(event.docs[0].data());
//   final faculty = await DbSession().getFacultybyUserId(session, ref);
//   session.faculty= faculty;
//     yield* session;
_handleError() {
  // print(event);
}

void _handleDone() {}
