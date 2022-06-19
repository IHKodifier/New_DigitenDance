import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/ui/authentication/login/login_page.dart';
import 'package:new_digitendance/ui/authentication/state/auth_state.dart';
import 'package:new_digitendance/ui/home/admin/admin_homepage.dart';
// import '../ui/startup/state/auth_notifier.dart';
import '../startup/state/startup_state.dart';
import '../state/institution_state.dart';

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
    // final _stream = ref.watch(authStateChangesStreamProvider);
    final startupState = ref.watch<StartupState>(startupStateNotifierProvider);
    ref.listen<StartupState>(startupStateNotifierProvider,
        (StartupState? previous, StartupState next) {
int x;
        x = 2;


      if (next.hasAuthentiatedUser) {
        
        ref
            .read(authenticationNotifierProvider.notifier)
            .grabAppUserFromDb(next.currentFirebaseUser!)
            .then((appUser) {
          log.d(
              'Detected existing user and now\n Grabbing AppUser from DB ${appUser.toString()}');
          ref
              .read(authenticationNotifierProvider.notifier)
              .setAuthenticatedUser(appUser: appUser);
          ref.read(institutionNotifierProvider.notifier).setDocRefOnInstitution(
              appUser.docRef.parent.parent
                  as DocumentReference<Map<String, dynamic>>);
        });
      }
    });

    return startupState.hasAuthentiatedUser
        ? AdminAppHomePage()
        : //return Login Page
        const LoginPage();
  }
}
