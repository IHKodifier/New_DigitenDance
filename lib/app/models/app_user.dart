import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import '../utilities.dart';

//An [AppUser] represents the user that has been authenticated to the system
///
///
/// NOTE
/// for each user in created in the
///    [Firebase Console -->Auth-->users ] Tab
/// the system creates a Doc in the Firestore at path
/// [/institutions/doc/users/]
@immutable
class AppUser extends Equatable {
  /// corresponds to the [identifier] in the
  /// [Firebase Console -->Auth-->users]
  String userId;

  /// corresponds to the [user_UUID] in  the
  /// [Firebase Console -->Auth-->users ]
  // String uUID;

  /// a list of [UserRole] assigned to the use in the system.
  /// they are stored in [roles] field of[array] type in  the corresponding [AppUser] doc at Firestore path [/institutions/doc/users/]
  List<UserRole> roles = [];

  /// This [AppUser]'s [DocumentReference] in the firestore
  DocumentReference<Map<String, dynamic>> docRef;

  /// getter to get the [photoURL] from [AdditionalAppUserInfo]
  String? get photoURL => additionalAppUserInfo?.photoUrl!;

  String? get email => additionalAppUserInfo?.email;

  ///This [AppUser]'sadditional metadata available like first sign in  etc.  from [FirebaseAuth]'s [User]
  AdditionalAppUserInfo? additionalAppUserInfo;

  AppUser({
    required this.userId,
    // required this.uUID,

    required this.roles,
    required this.docRef,
    this.additionalAppUserInfo,
  });

  AppUser adminFromCredentials(UserCredential credential,
      DocumentReference<Map<String, dynamic>> documentReference) {
    // throw UnimplementedError('fromCredentils not implemented in APUser.dart');
    ///TODO implement function
    return AppUser(
        userId: credential.user!.email!,
        //  uUID: uUID,
        roles: [UserRole.admin],
        docRef: documentReference);
  }

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      userId,
      // uUID,
      roles,
      docRef,
      additionalAppUserInfo!,
    ];
  }

  AppUser copyWith({
    String? userId,
    String? uUID,
    List<UserRole>? roles,
    DocumentReference<Map<String, dynamic>>? docRef,
    AdditionalAppUserInfo? additionalAppUserInfo,
  }) {
    return AppUser(
      userId: userId ?? this.userId,
      // uUID: uUID ?? this.uUID,
      roles: roles ?? this.roles,
      docRef: docRef ?? this.docRef,
      additionalAppUserInfo:
          additionalAppUserInfo ?? this.additionalAppUserInfo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    // result.addAll({'uUID': uUID});
    result.addAll({'roles': roles.map((x) => x.toMap()).toList()});
    // var intitutionDocRef = docRef;
    // var userDocRef = DbApi()
    //     .dbAppUser
    //     .db
    //     .doc(intitutionDocRef.path)
    //     .collection('users')
    //     .doc();
    result.addAll({'docRef': docRef.path});
    if (additionalAppUserInfo != null) {
      result.addAll({'additionalAppUserInfo': additionalAppUserInfo!.toMap()});
    }

    return result;
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    String docPath = map['docRef'];
    DocumentReference<Map<String, dynamic>> _docRef =
        FirebaseFirestore.instance.doc(docPath);
    return AppUser(
      userId: map['userId'] ?? 'not set',
      // uUID: map['uUID'] ?? 'not set',
      roles: List<UserRole>.from(map['roles']?.map((x) => UserRole.fromMap(x))),
      docRef: _docRef,
      additionalAppUserInfo: map['additionalAppUserInfo'] != null
          ? AdditionalAppUserInfo.fromMap(map['additionalAppUserInfo'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(userId: $userId,  roles: $roles, docRef: $docRef, additionalAppUserInfo: $additionalAppUserInfo)';
  }
}

class AdditionalAppUserInfo {
  String? disPlayName;

  String? email;

  String? photoUrl;

  var providerId;

  AdditionalAppUserInfo({
    this.disPlayName,
    this.email,
    this.photoUrl,
    this.providerId = 'Email',
  }) {
    assert(email != null);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (disPlayName != null) {
      result.addAll({'disPlayName': disPlayName});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (photoUrl != null) {
      result.addAll({'photoUrl': photoUrl});
    }
    result.addAll({'providerId': providerId.toMap()});

    return result;
  }

  factory AdditionalAppUserInfo.fromMap(Map<String, dynamic> map) {
    return AdditionalAppUserInfo(
      disPlayName: map['disPlayName'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      providerId: map['providerId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdditionalAppUserInfo.fromJson(String source) =>
      AdditionalAppUserInfo.fromMap(json.decode(source));
}

class UserRole {
  const UserRole(this.roleName);

  final String roleName;
  static const UserRole admin = UserRole('Admin');
  static const UserRole faculty = UserRole('Faculty');
  static const UserRole student = UserRole('Student');
//  static UserRole demo = UserRole('demo');
  @override
  String toString() {
    return roleName;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'roleName': roleName});

    return result;
  }

  factory UserRole.fromMap(Map<String, dynamic> map) {
    return UserRole(
      map['roleName'] ?? 'not set',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRole.fromJson(String source) =>
      UserRole.fromMap(json.decode(source));
}
