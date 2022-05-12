import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

class Institution extends Equatable {
  Institution({
    required this.title,
    required this.id,
    this.address,
    required this.docRef,
  });

  factory Institution.fromJson(String source) =>
      Institution.fromMap(json.decode(source));

  factory Institution.fromMap(Map<String, dynamic> map) {
    final _docRef = DbApi().documentReferenceFromPath(map['docRef']);
    return Institution(
        title: map['title'] ?? '',
        id: map['id'] ?? '',
        address: map['address'],
        docRef: _docRef);
  }

   String? address;
   DocumentReference<Map<String,dynamic>> docRef;
   String? id;
   String? title;

  @override
  // TODO: implement props
  List<Object> get props => [title!, id!, address ?? 'not set', docRef];

  @override
  String toString() {
    return 'Institution(title: $title, id: $id, address: $address, docRef: ${docRef.path.toString()})';
  }

  Institution copyWith({
    String? title,
    String? id,
    String? address,
    DocumentReference<Map<String, dynamic>>? docRef,
  }) {
    return Institution(
      title: title ?? this.title,
      id: id ?? this.id,
      address: address ?? this.address,
      docRef: docRef ?? this.docRef,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'id': id});
    if (address != null) {
      result.addAll({'address': address});
    }
    result.addAll({'docRef': docRef.path});

    return result;
  }

  String toJson() => json.encode(toMap());
}
