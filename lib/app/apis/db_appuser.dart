import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_digitendance/app/models/app_user.dart';

import '../models/institution.dart';
import '../utilities.dart';

class DbAppUser {
  final db = FirebaseFirestore.instance;

  DbAppUser();
  Future createSignUpUserInDb({
    required AppUser appUser,
    required Institution institution,
  }) async {
    try {
      
      await db
          // .collection('institutions')
          .doc('/'+institution.docRef.path)
          .collection('users')
          .doc()
          .set(appUser.toMap());
    } catch (e) {
      Utils.log(e.toString());
    }
  }

  Future<String> createInstitution(Institution institution) async {
    // var _docref = db.collection('institutions').doc();
    // institution.docRef = _docref;
    try {
      await db
          // .collection('institutions')
          .doc(institution.docRef.path)
          .set(institution.toMap())
          .then(
            (value) => Utils.log(
              'Instituion created ${institution.toString()}',
            ),
          );
    } catch (e) {
      Utils.log(e.toString());
    }

    return institution.docRef.path;
  }
}
