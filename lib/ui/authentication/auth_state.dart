import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_digitendance/app/apis/db_appuser.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/authapi.dart';
import 'package:new_digitendance/app/base_app_state.dart';
import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/app/models/institution.dart';

import '../../app/contants.dart';
import '../authentication/auth_state.dart';

///[authApiProvider]] provides  the [AuthApi] to the system
final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(
    FirebaseAuth.instance,
  ),
);

///[authStateNotifierProvider]] provides the [StateNotifier] of type [AuthState] .[AuthStateNotifier] uses [AuthApi] calls to
/// perform db Tasks
final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(
    AuthState,
    ref,
  );
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(
    state,
    this.thisref,
  ) : super(AuthState());
  // final AppUser appUser;
  // User? user;
  // AuthApi? authApi;
  StateNotifierProviderRef<AuthStateNotifier, AuthState> thisref;
  bool? get isBusy => state.isBusy;
  bool get isNotBusy => !isBusy!;

  void setAuthenticatedUser({required AppUser appUser}) {
    state = state.copyWith(authenticatedUser: appUser);
  }
  // Future<void> login({
  //   required LoginProviderType loginProvider,
  //   required String email,
  //   required String password,
  // }) async {
  //   authApi = thisref.watch(authApiProvider);
  //   user = await authApi?.login(
  //     loginProvider: LoginProviderType.EmailPassword,
  //     email: email,
  //     password: password,
  //   );
  //   if (user != null) await setUserInAuthState(user);
  // }

  /// function to sign up by creating a [FirebaseAuth ] user with emaila user with Email and password and acreate [Institution] and [AppUser] by calling [createSignUpUserInDb] on [DbAppUser]
  /// function    and
  /// password and if success
  ///
  Future<AppUser> signUpUser(
      {required String email,
      required String password,
      required Institution institution,
      required LoginProviderType loginProviderType}) async {
    final dbApi = thisref.read(dbApiProvider);
    final AuthApi = thisref.read(authApiProvider);

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
      roles: const [UserRole.admin,
      ],
    );
    final updatedAppUser = await dbApi.dbAppUser
        .createSignUpUserInDb(appUser: appUser, institution: institution);
    return updatedAppUser;
  }

  // setUserInAuthState(User? user) async {
  //   //TODO transform to AppUser and set then set state
  //   final dbApi = thisref.watch(dbApiProvider);
  //   var data = await DbApi.getAppUserDoc(userId: user!.email, refBase: thisref);
  //   AppUser appUser = AppUser.fromJson(data.docs[0].data(), user.email);
  //   // appUser = AppUser.fromFirebaseUser(user!);
  //   // final authstate = thisref.watch(authStateProvider);
  //   // var newState = AuthState().initializeFrom(state);
  //   // newstate.
  //   AuthState newState = AuthState().cloneFrom(state);
  //   newState.authenticatedUser = appUser;
  //   // newState.authenticatedUser!.additionalAppUserInfo!.email = user.email;
  //   newState.hasAuthenticatedUser = true;
  //   newState.isBusy = false;
  //   newState.selectedRole = newState.authenticatedUser!.roles[0];
  //   // Utilities.log(''''
  //   //   AuthState equals
  //   //   ${state.toString()}
  //   //   ''');
  //   state = newState;
  //   Utils.log(''''
  //     AuthState has been updated . new state equals
  //     ${newState.toString()}
  //     ''');
  // }

  void setBusy() {
    state = state.copyWith(isBusy: true);
  }

  void setIdle() {
    state = state.copyWith(isBusy: false);
  }

  // void getIdle() {
  //   state = state.copyWith(busyStatus: false);
  // }

}

class AuthState extends Equatable {
  late bool? isBusy;
  AppUser? authenticatedUser;
  UserRole? selectedRole;
  AuthState({
    this.authenticatedUser,
    this.selectedRole,
    this.isBusy = false,
  });

  @override
  // TODO: implement props
  List<Object> get props => [isBusy!, authenticatedUser!, [selectedRole]];

  AuthState copyWith({
    AppUser? authenticatedUser,
    UserRole? selectedRole,
    bool? isBusy,
  }) {
    return AuthState(
      authenticatedUser: authenticatedUser ?? this.authenticatedUser,
      selectedRole: selectedRole ?? this.selectedRole,
      isBusy: isBusy ?? this.isBusy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (authenticatedUser != null) {
      result.addAll({'authenticatedUser': authenticatedUser!.toMap()});
    }
    if (selectedRole != null) {
      result.addAll({'selectedRole': selectedRole!.toMap()});
    }

    return result;
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      authenticatedUser: map['authenticatedUser'] != null
          ? AppUser.fromMap(map['authenticatedUser'])
          : null,
      selectedRole: map['selectedRole'] != null
          ? UserRole.fromMap(map['selectedRole'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source));
}
