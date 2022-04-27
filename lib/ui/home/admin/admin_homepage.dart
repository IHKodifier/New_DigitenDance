import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/authentication/login/login_page.dart';

import '../../authentication/state/auth_state.dart';
import '../../authentication/state/authentication_notifier.dart';
import 'state/admin_state.dart';

class AdminAppHomePage extends ConsumerWidget {
  var thisRef;
  AdminAppHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminstate = ref.watch(adminStateNotifierProvider);
    thisRef = ref;
    final availableCourses =
        ref.watch(adminStateNotifierProvider).availableCourses;
    // availableCourses
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                AuthenticationNotifier notifier =
                    thisRef.read(authenticationNotifierProvider.notifier);
                notifier.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => LoginPage())));
              },
              icon: const Icon(Icons.logout),
              iconSize: 40,
            ),
          ],
        ),
        body: const Center(
          child: Center(
            child: Text('Admin App Home'),
            // ListView.builder(itemBuilder: (context,index){return ListTile(title: Text(availableCourses![index].courseTitle!),);}),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text('Admin Home'),
            //     ElevatedButton(
            //         onPressed: () {
            //           thisRef.read(authStateNotifierProvider.notifier).signOut();
            //           Navigator.of(context).pushReplacement(
            //             MaterialPageRoute(
            //               builder: ((context) => LoginPage()),
            //             ),
            //           );
            //         },
            //         child: const Text('Log out ')),
            // ],
          ),
        ));
    // );
  }
}
