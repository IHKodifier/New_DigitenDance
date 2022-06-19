import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';

/// License Information
///
///
///[institutionNotifierProvider] provides  the [StateNotifier<InstitutionNotifier>] to manage the  active [Institution] in the system. Each [Institution] is created in the Firestore at path  [/institutions/docId]
final institutionNotifierProvider =
    StateNotifierProvider<InstitutionNotifier, Institution>((ref) {
  return InstitutionNotifier(
    ref,
  );
});

///[InstitutionNotifier] manages and notifies the state of active [Institution] that belongs to the logged in [AppUser]
class InstitutionNotifier extends StateNotifier<Institution> {
  InstitutionNotifier(this.ref, [state])
      : super(
          state ??
              Institution(
                id: 'not set',
                title: 'not set',
                docRef:
                    // ref.read(authenticationNotifierProvider).authenticatedUser?.docRef.parent.parent,
                    DbApi().documentReferenceFromPath('/institutions/initial'),
              ),
        ) {
    // final user = ref.read(authenticationNotifierProvider).authenticatedUser;
    // if (user != null) {
    //    ref
    //       .read(authenticationNotifierProvider.notifier)
    //       .getInstitutionforUser();
    //   this.state.docRef = user.docRef.parent.parent!.path
    //       as DocumentReference<Map<String, dynamic>>;
    // } else {}
  }

  /// object to log the console output
  var logger = Logger(printer: PrettyPrinter());

  ///ref to access other provider from this class
  final StateNotifierProviderRef<InstitutionNotifier, Institution> ref;

  /// sets the [state] to data passed to the function
  void setInstitution(Institution data) {
    logger
        .i('setting institution state to....received data ${data.toString()}');
    state = data;

    logger.i('state has been successfuly set to ... ${state.toString()}');
  }

  void setDocRefOnInstitution(
      DocumentReference<Map<String, dynamic>> documentReference) {
    state = state.copyWith(docRef: documentReference);
  }
  // InstitutionNotifier copyWith({
  //   StateNotifierProviderRef<InstitutionNotifier, Institution>? ref,
  // }) {
  //   return InstitutionNotifier(
  //     ref ?? this.ref,
  //   );
  // }
}
