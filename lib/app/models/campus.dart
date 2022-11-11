import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

class Campus extends Equatable {
  String id;
  String title;
  String address;
  List<String>? phones;
  List<String>? links;
  DocumentReference<Map<String, dynamic>> docRef;
  Campus({
    required this.id,
    required this.title,
    required this.address,
    this.phones,
    this.links,
    required this.docRef,
  });
  @override
  // TODO: implement props
  List<Object> get props {
    return [
      id,
      title,
      address,
      // phones,
      // links,
      docRef,
    ];
  }

  Campus copyWith({
    String? id,
    String? title,
    String? address,
    List<String>? phones,
    List<String>? links,
    DocumentReference<Map<String, dynamic>>? docRef,
  }) {
    return Campus(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      phones: phones ?? this.phones,
      links: links ?? this.links,
      docRef: docRef ?? this.docRef,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'address': address});
    if(phones != null){
      result.addAll({'phones': phones});
    }
    if(links != null){
      result.addAll({'links': links?.map((e) => e).toList()});
    }
    result.addAll({'docRef': docRef.path});
  
    return result;
  }

  factory Campus.fromMap(Map<String, dynamic> map) {
    return Campus(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      address: map['address'] ?? '',
      phones: List<String>.from(map['phones']),
      links: List<String>.from(map['links']),
      docRef: DbApi().documentReferenceFromStringPath(map['docRef']),
      // DocumentReference<Map<String, dynamic>>.fromMap(map['docRef']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Campus.fromJson(String source) => Campus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Campus(id: $id, title: $title, address: $address, phones: $phones, links: $links, docRef: $docRef)';
  }
}
