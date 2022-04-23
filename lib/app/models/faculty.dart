import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Faculty extends Equatable {
  // final String name;
  final String userId;
  String? firstName;
  late String? lastName, title, photoURL;
  late DocumentReference? docRef;
  Faculty({
    required this.userId,
    this.firstName,
    required this.photoURL,
    this.docRef,
  });
 




  @override
  // TODO: implement props
  List<Object> get props => [userId, firstName!, photoURL!];
  

  Faculty copyWith({
    String? userId,
    String? firstName,
    String? lastName, title, 
    String? photoURL,
     DocumentReference? docRef,
  }) {
    return Faculty(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      photoURL: photoURL ?? this.photoURL,
      docRef: docRef ?? this.docRef,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userId': userId});
    if(firstName != null){
      result.addAll({'firstName': firstName});
    }
    result.addAll({'photoURL': photoURL});
    if(docRef != null){
      result.addAll({'docRef': docRef!.path});
    }
  
    return result;
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      userId: map['userId'] ?? '',
      firstName: map['firstName'],
      photoURL: map['photoURL'],
      docRef: map['docRef'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) => Faculty.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Faculty(userId: $userId, firstName: $firstName, photoURL: $photoURL, docRef: $docRef)';
  }
}
