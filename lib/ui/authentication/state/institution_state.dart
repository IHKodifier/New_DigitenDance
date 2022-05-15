
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/app/utilities.dart';

///[institutionNotifierProvider] provides  the [StateNotifier<InstitutionNotifier>] to manage the  active [Institution] in the system. Each [Institution] is created in the Firestore at path  [/institutions/docId]

final institutionNotifierProvider =
    StateNotifierProvider<InstitutionNotifier, Institution>((ref) {
  return InstitutionNotifier(
    ref,
    // Institution(
    //     id: 'not set', title: 'not set', docRef: null as DocumentReference<Map<String, dynamic>>),
  );
});








///[InstitutionNotifier] manages and notifies the state of active [Institution] that belongs to the logged in [AppUser]
class InstitutionNotifier extends StateNotifier<Institution> {
  InstitutionNotifier(this.ref, [state]) : super(state??Institution(
    id: 'not set',
    title: 'not set',
    docRef: DbApi().documentReferenceFromPath('/institutions/initial')
  ));

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
