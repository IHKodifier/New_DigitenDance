import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/models/app_user.dart';

import '../models/institution.dart';
import '../utilities.dart';

class DbAppUser {
  final db = FirebaseFirestore.instance;

  DbAppUser();
    var logger = Logger(
    printer: PrettyPrinter()
  );

  ///[createSignUpUserInDb] will perform bath write on db to
  ///
  /// 1---> cretes a new [Institution] with default values and the
  /// user defined [title] in the [institutions]collection of db
  ///
  /// 2--> create a new [Appuser] with const [UserRole.admin]
  ///  in the [institution/user] collection of db
  ///
  Future createSignUpUserInDb({
    required AppUser appUser,
    required Institution institution,
  }) async {
    WriteBatch batch = db.batch();

    /// set the [Institution] doc in the db
    batch.set(
      db.doc(appUser.docRef!.path),
      institution.toMap(),
    );

    /// set the [AppUser] doc in the db
    /// get reference for user doc
    DocumentReference<Map<String, dynamic>> appUserDocRef =
        db.doc(institution.docRef!.path).collection('users').doc();

    /// update [appUserDocRef] in [appUser]
    appUser.docRef = appUserDocRef;

    ///
    ///
    ///
    ///
    ///
    batch.set(appUserDocRef, appUser.toMap());
    batch.commit();

    ///first create the institution

    // String institutionPath = await createInstitution(institution);

    // /// create [FirebaseAuth] user
    // try {
    //   await db
    //       // .collection('institutions')
    //       .doc('/' + institution.docRef.path)
    //       .collection('users')
    //       .doc()
    //       .set(appUser.toMap());
    // } catch (e) {
    //   logger.i(e.toString());
    // }
    return appUser;
  }

  Future<String> createInstitution(Institution institution) async {
    // var _docref = db.collection('institutions').doc();
    // institution.docRef = _docref;
    try {
      await db
          // .collection('institutions')
          .doc(institution.docRef!.path)
          .set(institution.toMap())
          .then(
            (value) => logger.i(
              'Instituion created ${institution.toString()}',
            ),
          );
    } catch (e) {
      logger.i(e.toString());
    }

    return institution.docRef!.path;
  }
}
