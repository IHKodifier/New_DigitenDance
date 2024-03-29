import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/ui/authentication/login/login_page.dart';
import 'package:new_digitendance/ui/home/admin/admin_homepage.dart';

import '../../../app/states/auth_state.dart';
import '../../../app/states/startup_state.dart';
// import '../ui/startup/state/auth_notifier.dart';

class StartupView extends ConsumerWidget {
  StartupView({Key? key}) : super(key: key);

  final log = Logger(
    printer: PrettyPrinter(),
  );

  late WidgetRef thisRef;

  void onPressed() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupState = ref.watch(startupStateNotifierProvider);
  
    if (startupState.hasAuthentiatedUser) {
      final AuthenticationNotifier =
          ref.read(authenticationNotifierProvider.notifier);
      AuthenticationNotifier.grabAppUserFromDb(
              startupState.currentFirebaseUser!)
          .then((appUser) {
        log.d('Grabbing AppUser from DB ${appUser.toString()}');
        AuthenticationNotifier.setAuthenticatedUser(appUser: appUser);
      });

      return AdminAppHomePage();
    } else {}
    return const LoginPage();
  }
}
