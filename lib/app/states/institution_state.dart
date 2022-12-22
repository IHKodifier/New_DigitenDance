import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/app/states/auth_state.dart';

/// License Information
///
///
///[institutionNotifierProvider] provides  the [AsyncValue<Institution>] to manage the  active [Institution] in the system. Each [Institution] is created in the Firestore at path  [/institutions/docId]
///
final institutionNotifierProvider =
    StateNotifierProvider<InstitutionNotifier, AsyncValue<Institution>>((ref) {
  var institution;
  ref.listen(authenticationNotifierProvider,
      (AuthenticationState? previous, AuthenticationState next) {
    if (previous == next) {}
    institution =
        ref.read(authenticationNotifierProvider.notifier).getUserInstitution();
  });

  return InstitutionNotifier(ref, institution);
});

//     StateNotifierProvider<InstitutionNotifier, Institution>((ref) {
//   ///for an [InstitutionNotifier] to be instantiated, there
//   ///must be an[AppUser] authenticated to the system .

//   ///STEP1 :check if a user is logged in to system. this is done
//   ///by vhecking the [authenticatedUser] on [authenticationNotifierProvider]

//   if (ref.read(authenticationNotifierProvider).authenticatedUser != null) {
//     ///set the user 's Institution in [institutionNotifierProvider]

//     Institution institution = Institution();
//     final authNotifier = ref.read(authenticationNotifierProvider.notifier);
//      authNotifier.setUserInstitution();

//     return InstitutionNotifier(ref, ref.read(institutionProvider));
//   } else {
//     throw Exception('No authenticated user detected');
//   }

//   return InstitutionNotifier(
//     ref,
//   );
// });

///[InstitutionNotifier] manages and notifies the state of active [Institution] that belongs to the logged in [AppUser]
class InstitutionNotifier extends StateNotifier<AsyncValue<Institution>> {
  InstitutionNotifier(this.ref, [state])
      : super(state ?? const AsyncValue<Institution>.loading());

  /// object to log the console output
  var logger = Logger(printer: PrettyPrinter());

  /// ref to access other provider from this class
  final StateNotifierProviderRef<InstitutionNotifier, AsyncValue<Institution>>
      ref;

  /// sets the [state] to data passed to the function
  void setInstitution(Institution data) {
    logger
        .i('setting institution state to....received data ${data.toString()}');
    state = AsyncValue.data(data);

    logger.i('state has been successfuly set to ... ${state.toString()}');
  }

  void setDocRefOnInstitution(
      DocumentReference<Map<String, dynamic>> documentReference) {}
}
