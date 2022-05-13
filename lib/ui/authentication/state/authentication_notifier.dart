import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';
import '../../../app/contants.dart';
import '../../../app/models/app_user.dart';
import '../../../app/models/institution.dart';
import '../../../app/utilities.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier(
    state,
    this.ref,
  ) : super(const AuthenticationState()) {
    db = ref.read(dbProvider);
  }

  /// [db]  exposes the [FireBaseFirestore] instance
  /// for this app
  late FirebaseFirestore db;

  ///ref to red and listen to other providers
  StateNotifierProviderRef<AuthenticationNotifier, AuthenticationState> ref;

  ///returns true if the state is busy currently
  bool? get isBusy => state.isBusy;

  ///returns true if the state is NOT busy currently
  bool get isNotBusy => !isBusy!;

  ///function to sign out the currently Signed in [AppUser]
  /// also signs out the [FireBaseAuth] users
  signOut() {
    FirebaseAuth.instance.signOut();
    state = state.copyWith(authenticatedUser: null);
  }

  ///function to set the [state.isBusy]  to [val]
  set setBusyTo(bool val) {
    state = state.copyWith(isBusy: val);
  }

  void setAuthenticatedUser({required AppUser appUser}) {
    state = state.copyWith(authenticatedUser: appUser);
  }

  /// function to login an [AppUser] with the provided
  /// [LoginProviderType]. On succesffull login , it will
  /// set the [authenticatedUser] and [selectedRole]
  /// on the [AuthenticationState]

  Future<bool> login({
    required LoginProviderType loginProvider,
    required String email,
    required String password,
  }) async {
    final authApi = ref.read(authApiProvider);
    final loggegInUser = await authApi.attemptLogin(
      loginProvider: LoginProviderType.EmailPassword,
      email: email,
      password: password,
    );

    //if [user] is not null get the db doc for [AppUser]
    ///and create [AppUser] fron the db doc.
    ///set the [Institution] in [institutionProvider]
    ///then set this user in [AuthenticationState]
    ///
    if (loggegInUser != null) {
      grabAppUserFromDb(loggegInUser).then((appUser) {
        Utils.log('Grabbing AppUser from DB ${appUser.toString()}');
        
            setAuthenticatedUser(appUser: appUser);
      });
      // Navigator.of(context).pop();
      return true;
    }
    return false;
  }

  /// function to sign up by creating a [FirebaseAuth ] user with
  /// the user provided  Email and password
  /// on successfull sgnUp. it will call [createSignUpUserInDb] on [DbAppUser]to create  the new [Institution] and create the  new [AppUser] doc in db at path  [/institutions/[institution doc/users/appUser Doc]
  Future<AppUser> signUpUser(
      {required String email,
      required String password,
      required Institution institution,
      required LoginProviderType loginProviderType}) async {
    final dbApi = ref.read(dbApiProvider);
    final AuthApi = ref.read(authApiProvider);

    UserCredential creadtedUserCredential;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      creadtedUserCredential = value;
    });

    ///
    AppUser appUser = AppUser(
      docRef: institution.docRef,
      userId: email,
      roles: const [
        UserRole.admin,
      ],
    );
    final updatedAppUser = await dbApi.dbAppUser
        .createSignUpUserInDb(appUser: appUser, institution: institution);
    return updatedAppUser;
  }

  /// function to grab [AppUser doc] from [db] and transform it
  /// to [AppUser] and then set the state
  Future<AppUser> grabAppUserFromDb(User user) async {
    // to grab [AppUser] db doc   [AppUser]'s institution needs to retreived  first
    var userQuerySnapshot = await db
        .collectionGroup('users')
        .where('userId', isEqualTo: user.email)
        .get();
    Utils.log(
        ' user\'s retrived : ${userQuerySnapshot.docs[0].data().toString()}');
    Utils.log(
        ' user\'s institutionPath : ${userQuerySnapshot.docs[0].reference.parent.parent?.path}');
    var _institutionDocRef = userQuerySnapshot.docs[0].reference.parent.parent!;

    var data =
        await db.collection('institutions').doc(_institutionDocRef.id).get();
    Institution institution = Institution.fromMap(data.data()!);
    AppUser appUser =
        AppUser.fromJson(json.encode(userQuerySnapshot.docs[0].data()));
    ref.read(institutionProvider.notifier).setInstitution(institution);
    return appUser;
  }
}
