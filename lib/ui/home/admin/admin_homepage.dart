import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/home/admin/admin_state.dart';

class AdminAppHomePage extends ConsumerWidget {
  const AdminAppHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminstate = ref.watch(adminStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Admin Home'),
            ElevatedButton(onPressed: onPressed, child: Text('Log out ')),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    FirebaseAuth.instance.signOut();
  }
}
