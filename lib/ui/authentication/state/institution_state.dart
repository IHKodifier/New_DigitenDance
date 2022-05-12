import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/app/utilities.dart';

///[institutionProvider] provides  the [StateNotifier<InstitutionNotifier>] to manage the  active [Institution] in the system. Each [Institution] is created in the Firestore at path  [/institutions/docId]

final institutionProvider =
    StateNotifierProvider<InstitutionNotifier, Institution>((ref) {
  return InstitutionNotifier(
    ref,
    // Institution(
    //     id: 'not set', title: 'not set', docRef: null as DocumentReference<Map<String, dynamic>>),
  );
});








///[InstitutionNotifier] manages and notifies the state of active [Institution] that belongs to the logged in [AppUser]
class InstitutionNotifier extends StateNotifier<Institution> {
  InstitutionNotifier(this.ref, [state]) : super(state);

  final StateNotifierProviderRef<InstitutionNotifier, Institution> ref;

  void setInstitution(Institution data) {
    Utils.log('setting institution....received data ${data.toString()}');
    state = data;
    Utils.log('state set to ... ${state.toString()}');
  }

  // InstitutionNotifier copyWith({
  //   StateNotifierProviderRef<InstitutionNotifier, Institution>? ref,
  // }) {
  //   return InstitutionNotifier(
  //     ref ?? this.ref,
  //   );
  // }
}
