import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/models/social_links.dart';

class Faculty extends Equatable {
  Faculty({
    required this.userId,
    this.firstName,
    this.lastName,
    this.photoURL,
    this.docRef,
    this.jobTitle,
    this.prefix = 'Mr.',
    this.phone = 'Not available',
    this.bio='bio not created by user',
    this.links = const [],
  });

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source));
  factory Faculty.minimalFromUserId(String userId) => Faculty(userId: userId);

  factory Faculty.fromMap(Map<String, dynamic> dataMap) {
    List<SocialLink> social_links=<SocialLink>[];
    for (var element in dataMap['links']) {
      social_links.add(SocialLink.fromMap(element));
      
    }
    
    Faculty faculty = Faculty(
        userId: dataMap['userId'] ?? '',
        firstName: dataMap['firstName'],
        lastName: dataMap['lastName'],
        photoURL: dataMap['photoURL'],
        jobTitle: dataMap['jobTitle'],
        prefix: dataMap['prefix'],
        bio: dataMap['bio'],
        docRef: DbApi().documentReferenceFromStringPath(dataMap['docRef'].path),
        phone: dataMap['phone'],
        links: social_links);
    return faculty;
  }

  late DocumentReference? docRef;
  String? firstName;
  late String? jobTitle;
  late String? bio;
  late String? lastName;
  late String? photoURL;
  final String prefix;
  final String userId;
  final String phone;
  final List<SocialLink> links;

  @override
  // TODO: implement props
  List<Object> get props => [userId, firstName!, photoURL!];

  @override
  String toString() {
    return 'Faculty(userId: $userId, $prefix firstName: $firstName $jobTitle, photoURL: $photoURL, docRef: $docRef),phone $phone links $links bio $bio' ;
  }

  static Faculty initial() {
    return Faculty(
      userId: 'not Initialized',
      firstName: 'not Initialized',
      photoURL: 'not Initialized',
      prefix: 'Mr.',
      docRef: DbApi().documentReferenceFromStringPath('institutions/default'),
    );
  }

  Faculty copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? prefix,
    String? photoURL,
    DocumentReference? docRef,
    String? phone,
    List<SocialLink>? links,
    // Faculty? faculty,
  }) {
    return Faculty(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        photoURL: photoURL ?? this.photoURL,
        phone: phone ?? this.phone,
        links: links ?? this.links,
        docRef: docRef ?? this.docRef,
        jobTitle: jobTitle ?? this.jobTitle);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'bio':bio});
    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (docRef != null) {
      result.addAll({'docRef': docRef!.path});
    }
    result.addAll({'photoURL': photoURL});
    if (jobTitle != null) {
      result.addAll({'jobTitle': jobTitle});
    }
    if (prefix != null) {
      result.addAll({'prefix': prefix});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (links != null) {
      result.addAll({'links': links});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
