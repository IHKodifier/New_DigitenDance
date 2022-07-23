import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';

import '../models/faculty.dart';

class DbFaculty {
  Future<Faculty>? getFacultyForCourse(ProviderRef ref) {
   return ref.read(dbProvider)
    .doc(ref.read(institutionNotifierProvider).value!.docRef!.path)
    .collection('faculty').get().then((value) {
      return Faculty.fromMap(value.docs[0].data());
      });
  
  }
}
