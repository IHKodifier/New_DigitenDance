import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import '../../app/apis/db_session.dart';
import '../../app/models/session.dart';




final sessionStreamProvider = StreamProvider<Session>((ref) async* {
  final _controller = StreamController<Session>();
   Session session=Session();
  final subscription = ref.read(dbProvider)
  .doc(ref.read(currentCourseProvider).docRef.path)
  .collection('sessions')
  .snapshots()

    //   //  _controller.sink.add(session);
    //  });
});