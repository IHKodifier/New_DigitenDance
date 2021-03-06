// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../app/utilities.dart';


// ///  checks for the [currentUser] property  of [FireBaseAuthInstance] to see if a user is already authenticated
// final currentAuthUserProvider = FutureProvider<User?>((ref) async {
//   return FirebaseAuth.instance.currentUser;
// });
// /// shall provide [AuthNotifier] and [AuthState]
// final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(AuthState, ref);
// });

// class AuthNotiYfier extends StateNotifier<AuthState> {
//   AuthNotifier(state, this.thisref) : super(AuthState());
//   // ignore: prefer_typing_uninitialized_variables
//   AppUser? appUser;
//   User? user;
//   AuthApi? authApi;
//   StateNotifierProviderRef<AuthNotifier, AuthState> thisref;

//   Future<void> login({
//     required LoginProvider loginProvider,
//     required String email,
//     required String password,
//   }) async {
//     authApi = thisref.watch(authApiProvider);
//     user = await authApi!.login(
//       loginProvider: LoginProvider.EmailPassword,
//       email: email,
//       password: password,
//     );
//     if (user != null) await setUserInAuthState(user);
//   }

//   setUserInAuthState(User? user) async {
//     //TODO transform to AppUser and set then set state
//     final firestoreService = thisref.watch(dbApiProvider);
//     var data = await firestoreService.getAppUserDoc(
//         userId: user!.email, refBase: thisref);
//     AppUser appUser = AppUser.fromJson(data.docs[0].data(), user.email);
//     // appUser = AppUser.fromFirebaseUser(user!);
//     // final authstate = thisref.watch(authStateProvider);
//     // var newState = AuthState().initializeFrom(state);
//     // newstate.
//     AuthState newState = AuthState().cloneFrom(state);
//     newState.authenticatedUser = appUser;
//     // newState.authenticatedUser!.additionalAppUserInfo!.email = user.email;
//     newState.hasAuthenticatedUser = true;
//     newState.isBusy = false;
//     newState.selectedRole = newState.authenticatedUser!.roles[0];
//     // Utilities.log(''''
//     //   AuthState equals
//     //   ${state.toString()}
//     //   ''');
//     state = newState;
//     logger.i(''''
//       AuthState has been updated . new state equals  
//       ${newState.toString()}
//       ''');
//   }

//   void setSelectedRole(UserRole role) {
//     AuthState newState = AuthState().cloneFrom(state);

//     newState.selectedRole = role;
//     // newState.authenticatedUser = state.authenticatedUser;
//     state = newState;
//   }

//   Future<void> signOut() async {
//     authApi = thisref.watch(authApiProvider);
//     await authApi!.signOut();
//     logger.i(FirebaseAuth.instance.currentUser.toString());
//   }
// }
