import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/ui/authentication/state/authentication_notifier.dart';

import '../../../app/apis/authapi.dart';

/// [dbProvider] provides an instance of [FirebaseFirestore.instance]
/// to the entire system
final dbProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

///[authApiProvider]] provides the [AuthApi] to the entire system
final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(
    FirebaseAuth.instance,
  ),
);

///[authenticationNotifierProvider]] provides the
///[AuthenticationNotifier] which manages the [AuthenticationState]
///and uses [AuthApi] calls to perform db Tasks
final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
  return AuthenticationNotifier(
    AuthenticationState,
    ref,
  );
});

///class to manage and notify state changes to [AuthenticationState]
///manages the budy/not busy states of the [AuthenticationState] by
/// providing a getter  [isBusy] and setter [setBusyTo]
/// provides methods like [signOut], [attemptLogin], [signUpUser]

class AuthenticationState extends Equatable {
   bool isBusy=false;
  final AppUser? authenticatedUser;
   UserRole? get  selectedRole=> authenticatedUser?.roles[0];
   AuthenticationState({
    this.authenticatedUser,
    this.isBusy = false,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        isBusy,
        authenticatedUser!,
        [selectedRole]
      ];

  AuthenticationState copyWith({
    AppUser? authenticatedUser,
    UserRole? selectedRole,
    bool? isBusy,
  }) {
    return AuthenticationState(
      authenticatedUser: authenticatedUser ?? this.authenticatedUser,
      // selectedRole: selectedRole ?? this.selectedRole,
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

  factory AuthenticationState.fromMap(Map<String, dynamic> map) {
    return AuthenticationState(
      authenticatedUser: map['authenticatedUser'] != null
          ? AppUser.fromMap(map['authenticatedUser'])
          : null,
      // selectedRole: map['selectedRole'] != null
      //     ? UserRole.fromMap(map['selectedRole'])
      //     : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromMap(json.decode(source));
}
