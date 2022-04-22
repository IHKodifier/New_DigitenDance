import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/authentication/login/login_page.dart';
// import '../ui/startup/state/auth_notifier.dart';
import '../startup/state/startup_state.dart';

class StartupView extends ConsumerWidget {
  StartupView({Key? key}) : super(key: key);
  late WidgetRef thisRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _stream = ref.watch(authStateChangesStreamProvider);
    final startupState = ref.read(startupStateNotifierProvider);

    return startupState.hasAuthentiatedUser
        ?
        // return Home
        Container(
            color: Colors.green,
          )
        : //return Login Page
        const LoginPage();

    
  }

  // _handleWhenData(User? user, WidgetRef ref) {
  //   if (user != null) {
  //     final notifier = ref.watch(authStateProvider.notifier);
  //     // final authState = thisRef.watch(authStateProvider);
  //     notifier.setUserInAuthState(user);
  //     return AppHomeView();
  //   } else {
  //     return LoginView();
  // }
  // }
}
