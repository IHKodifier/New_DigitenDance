import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/app/models/institution.dart';

///[institutionProvider] provides  the [StateNotifier<InstitutionNotifier>] to manage the  active [Institution] in the system. Each [Institution] is created in the Firestore at path  [/institutions/docId]

final institutionProvider =
    StateNotifierProvider<InstitutionNotifier, Institution>((ref) {
  return InstitutionNotifier(
      ref,
      Institution(
          id: 'not set', title: 'not set', docRef: null as DocumentReference<Map<String, dynamic>>));
});

///[InstitutionNotifier] manages and notifies the state of active [Institution] thatbelongs to the logged in [AppUser]
class InstitutionNotifier extends StateNotifier<Institution> {
  final StateNotifierProviderRef<InstitutionNotifier, Institution> ref;

  InstitutionNotifier(this.ref, [state]) : super(state);

  void setInstitution(Institution data) {
    state = data;
  }

  InstitutionNotifier copyWith({
    StateNotifierProviderRef<InstitutionNotifier, Institution>? ref,
  }) {
    return InstitutionNotifier(
      ref ?? this.ref,
    );
  }

  

 

}
