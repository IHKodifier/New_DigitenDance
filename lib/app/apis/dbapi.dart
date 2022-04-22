import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/app_services.dart';
import 'package:new_digitendance/app/apis/db_appuser.dart';
import 'package:new_digitendance/app/apis/db_course.dart';
import 'package:new_digitendance/app/apis/db_faculty.dart';
import 'package:new_digitendance/app/apis/db_session.dart';

import 'db_faculty.dart';
///TODO add license info

final appServicesProvider = Provider<AppServices>((ref) {
  return AppServices();
});


/// [DbApi] is the system's only API to READ from or
/// WRITE to the [FirebaseFirestore.instance].
/// it uses cascaded sub clasess of
/// [DbAppUser],[DbCourse],[DbSession],[DbFaculty]
/// TODO add more sub classes when updated
class DbApi {
  final DbAppUser _dbAppUser = DbAppUser();
  final DbCourse _dbCourse = DbCourse();
  final DbSession _dbSession = DbSession();
  final DbFaculty _dbFaculty = DbFaculty();
  DbAppUser get dbAppUser => _dbAppUser;
  DbCourse get dbCourse => _dbCourse;
  DbFaculty get dbFaculty => _dbFaculty;
  DbSession get dbSession => _dbSession;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late QuerySnapshot<Map<String, dynamic>> querySnapshot;
  late DocumentReference _institutionDocRef;



  /// helper function to conveert a document path to
  ///  a [DocumentReference]
  DocumentReference<Map<String, dynamic>> documentReferenceFromPath(
          String path) =>
      _db.doc(path);
 

  // DocumentReference? get institutionDocRef {
  //   if (_institutionDocRef != null) {
  //     return _institutionDocRef;
  //   } else {
  //     // throw UnimplementedError();
  //     return null;
  //   }
  // }

}
