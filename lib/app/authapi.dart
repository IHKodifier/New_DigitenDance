import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/app_services.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/app/utilities.dart';

final authApiProvider =
    Provider<AuthApi>((ref) => AuthApi(FirebaseAuth.instance));

class AuthApi {
  late FirebaseAuth instance;
  late UserCredential? userCredential;
  Institution? _institution;
  String _email = '';
  String _path = '';
  String _password = '';
  String _defaultPhotoURL=' https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png';
  // ignore: prefer_final_fields
  // String _phone = '';

  AuthApi(this.instance);

  Stream<User?> get authStateChanges => instance.authStateChanges();

  Future<User?> login({
    required LoginProviderType loginProvider,
    required String email,
    required String password,
  }) async {
    _email = email;
    _password = password;
    dynamic returnvalue;
    switch (loginProvider) {
      case LoginProviderType.EmailPassword:
        returnvalue = signInwithEmail();
        break;
      case LoginProviderType.Facebook:
        returnvalue = signInwithFacebook();
        break;
      case LoginProviderType.Google:
        returnvalue = signInwithGoogle();
        break;
      case LoginProviderType.Phone:
        returnvalue = signInwithPhone();
        break;

      default:
    }
    return returnvalue;
  }

  bool checkExistingUser() {
    return instance.currentUser != null;
  }

  Future<User?> signInwithEmail() async {
    try {
      userCredential = await instance.signInWithEmailAndPassword(
          email: _email, password: _password);
    } catch (e) {
      Utils.log(e.toString());
    }
    if (userCredential?.user!= null) {
      return userCredential?.user;
    } else {
      return null;
    }
  }

  Future<User?> signInwithGoogle() async {
    throw UnimplementedError();
  }

  Future<User?> signInwithFacebook() async {
    throw UnimplementedError();
  }

  Future<User?> signInwithPhone() async {
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    await instance.signOut();
  }

  ///[signUp] creates a new [AppUser] both
  /// in the [Firebase Console-->Auth-->Users] tab as well as in
  /// the path [/instituion/users].
  /// the [Institution]  doc will immediately be created after
  /// the  [createUserWithEmailAndPassword] of [FirebaseAuth]
  /// return a [UserCredential] with non null [user] property
  Future<void> signUp(
      {required String email,
      required String password,
      required Institution institution}) async {
    _institution = institution;
    this._email = email;
    this._password = password;
    
    try {
      userCredential = await instance
          .createUserWithEmailAndPassword(email: _email, 
          password: _password,)
          .then((onSignUpSuccess));
    } catch (e) {
      Utils.log(e.toString());
    }
  }

  FutureOr<UserCredential?> onSignUpSuccess(UserCredential value) async {
    /// upon sign Up success immediately create the new [Institution] and store document path in [_path]
    await AppServices.dbService.dbAppUser.createInstitution(_institution!);
    AppUser _appUser =
        AppUser(userId: _email,
         docRef: AppServices.dbService.documentReferenceFromPath(_path),
         roles:const <UserRole>[
          UserRole.admin,
          UserRole.faculty,
          UserRole.student,
                   
        ],
         additionalAppUserInfo: AdditionalAppUserInfo(photoUrl:_defaultPhotoURL,
           ),

         );
    await AppServices.dbService.dbAppUser.createSignUpUserInDb(
      appUser: _appUser,
      institution: _institution!
      );


    /// create a new [AppUser] in firestore
  }
}
