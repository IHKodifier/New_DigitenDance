import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

class Faculty extends Equatable {
  Faculty({
    required this.userId,
    this.firstName,
    this.photoURL,
    this.docRef,
  });

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source));

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      userId: map['userId'] ?? '',
      firstName: map['firstName'],
      photoURL: map['photoURL'],
      docRef: DbApi().documentReferenceFromStringPath(map['docRef']),
    );
  }

  late DocumentReference? docRef;
  String? firstName;
  late String? lastName;
  late String? photoURL;
  late String? title;
  final String userId;

  @override
  // TODO: implement props
  List<Object> get props => [userId, firstName!, photoURL!];

  @override
  String toString() {
    return 'Faculty(userId: $userId, firstName: $firstName, photoURL: $photoURL, docRef: $docRef)';
  }

  static Faculty initial() {
    return Faculty(
      userId: 'not Initialized',
      firstName: 'not Initialized',
      photoURL: 'not Initialized',
      docRef: DbApi().documentReferenceFromStringPath('institutions/default'),
    );
  }

  Faculty copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    // title,
    String? photoURL,
    DocumentReference? docRef,
    // Faculty? faculty,
  }) {
    return Faculty(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      photoURL: photoURL ?? this.photoURL,
      docRef: docRef ?? this.docRef,
      // title:
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    result.addAll({'photoURL': photoURL});
    if (docRef != null) {
      result.addAll({'docRef': docRef!.path});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
