import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/models/faculty.dart';
import 'package:new_digitendance/app/models/session.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';

class DbSession {
  Future<Faculty> getFacultybyUserId(Session session,StreamProviderRef ref) async {
    return   ref.read(dbProvider).doc(ref.read(institutionNotifierProvider).value!
    .docRef!.path).collection('faculty')
 .where('userId',isEqualTo: session.faculty!.userId).
 get().
 then((snapshot) => Faculty.fromMap(snapshot.docs[0].data()));
 

 



  }
}
