import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_digitendance/app/models/app_user.dart';
import 'package:new_digitendance/ui/authentication/startup/startup_view.dart';

final startupStateNotifierProvider =
    StateNotifierProvider<StartupStateNotifier, StartupState>((ref) {
  return StartupStateNotifier();
});

class StartupStateNotifier extends StateNotifier<StartupState> {
  StartupStateNotifier([state]) : super(state ?? StartupState());


}

class StartupState extends Equatable {
  bool _hasAuthenticatedUser = false;
  StartupState() {
    Firebase.initializeApp();
    _hasAuthenticatedUser = (FirebaseAuth.instance.currentUser != null);
  }

//check for existing User
//TODO do proper api based checking
  bool get hasAuthentiatedUser => _hasAuthenticatedUser;

  @override
  // TODO: implement props
  List<Object?> get props => [hasAuthentiatedUser];
  User? get currentFirebaseUser => FirebaseAuth.instance.currentUser;
}
