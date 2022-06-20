import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';
import '../../../app/contants.dart';
import '../../../app/models/app_user.dart';
import '../../../app/models/institution.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier(
    state,
    this.ref,
  ) : super(AuthenticationState()) {
    db = ref.read(dbProvider);
  }

  /// [db]  exposes the [FireBaseFirestore] instance
  /// for this app
  late FirebaseFirestore db;

  var log = Logger(printer: PrettyPrinter());

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
    // ref.read(institutionNotifierProvider.notifier).state = null as Institution;
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
  /// grab the [AppUser] by calling [grabAppUserFromDb] then
  /// set the [authenticatedUser] ,[selectedRole]
  /// on the [AuthenticationState]
  /// and [Institution] on the [InstitutionNotifier] by calling [getInstitutionforUser]

  Future login({
    required LoginProviderType loginProvider,
    required String email,
    required String password,
  }) async {
    final authApi = ref.read(authApiProvider);
    final attemptedUser = await authApi.attemptLogin(
      loginProvider: LoginProviderType.EmailPassword,
      email: email,
      password: password,
    );

    //if the returned [user] is not null then  get the db doc for [AppUser]
    ///and create [AppUser] fronm the db doc.
    ///set the [Institution] in [institutionProvider]
    ///then set this user in [AuthenticationState]
    ///
    if (attemptedUser != null) {
      grabAppUserFromDb(attemptedUser).then((appUser) {
        log.d('Grabbing AppUser from DB ${appUser.toString()}');
        setAuthenticatedUser(appUser: appUser);
        ref.read(institutionNotifierProvider.notifier).setDocRefOnInstitution(
            appUser.docRef!.parent.parent
                as DocumentReference<Map<String, dynamic>>);

        // ref.read(institutionNotifierProvider).docRef = appUser
        //     .docRef.parent.parent as DocumentReference<Map<String, dynamic>>;
      });
      return true;
    }
    return false;
  }

  /// function to sign up [AppUser] by creating a [FirebaseAuth ] user with   /// the user provided  Email and password
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

  ///function to grab [Institution] of the provided [User]
  void getInstitutionforUser() async {
    var userEmail =
        ref.read(authenticationNotifierProvider).authenticatedUser?.email;
    var userQuerySnapshot = await db
        .collectionGroup('users')
        .where('userId', isEqualTo: userEmail)
        .get();
    log.d(' user\'s retrived : ${userQuerySnapshot.docs[0].data().toString()}');
    log.d(
        ' user\'s institutionPath : ${userQuerySnapshot.docs[0].reference.parent.parent?.path}');

    ///reference to the  Institution where
    /// the current [AppUser] belongs
    var _institutionDocRef = userQuerySnapshot.docs[0].reference.parent.parent!;

    var instituionData = await db.doc(_institutionDocRef.path).get();
    Institution institution = Institution.fromMap(instituionData.data()!);
    ref.read(institutionNotifierProvider.notifier).setInstitution(institution);
  }

  /// function to grab [AppUser doc] from [db] and transform it
  /// to [AppUser] and then set the state

  Future<AppUser> grabAppUserFromDb(User user) async {
    /// to grab an [AppUser] db doc, the  [AppUser]'s institution needs to retreived  first
    var userQuerySnapshot = await db
        .collectionGroup('users')
        .where('userId', isEqualTo: user.email)
        .get();
    log.d(' user\'s retrived : ${userQuerySnapshot.docs[0].data().toString()}');
    log.d(
        ' user\'s institutionPath : ${userQuerySnapshot.docs[0].reference.parent.parent?.path}');

    ///reference to the  Institution where
    /// the current [AppUser] belongs
    var _institutionDocRef = userQuerySnapshot.docs[0].reference.parent.parent!;

    var instituionData = await db.doc(_institutionDocRef.path).get();
    Institution institution = Institution.fromMap(instituionData.data()!);
    AppUser appUser =
        AppUser.fromJson(json.encode(userQuerySnapshot.docs[0].data()));
    ref.read(institutionNotifierProvider.notifier).setInstitution(institution);
    return appUser;
  }
}
