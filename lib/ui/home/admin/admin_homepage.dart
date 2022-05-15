import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/course.dart';
import 'package:new_digitendance/app/utilities.dart';
import 'package:new_digitendance/ui/authentication/login/login_page.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

import '../../authentication/state/auth_state.dart';
import '../../authentication/state/authentication_notifier.dart';
import 'state/admin_state.dart';

class AdminAppHomePage extends ConsumerWidget {
  AdminAppHomePage({Key? key}) : super(key: key);
  late BuildContext _context;

  var thisRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var adminstate = ref.watch(adminStateNotifierProvider);
    thisRef = ref;
    _context = context;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                AuthenticationNotifier notifier =
                    thisRef.read(authenticationNotifierProvider.notifier);
                notifier.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              },
              icon: const Icon(Icons.logout),
              iconSize: 40,
            ),
          ],
        ),
        body: Center(
          child: Center(
            child: adminstate.availableCourses
                ?.when(data: onData, error: onError, loading: onLoading),
          ),
        ));

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
    // );
  }

  Widget? onData(List<Course> data) {
    Utils.log('printing onData ${data.toString()}');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Admin Home'),
        ElevatedButton(
            onPressed: () {
              thisRef.read(authenticationNotifierProvider.notifier).signOut();
              Navigator.of(_context).pushReplacement(
                MaterialPageRoute(
                  builder: ((context) => LoginPage()),
                ),
              );
            },
            child: const Text('Log out ')),
      ],
    );
  }

  Widget? onError(Object error, StackTrace? stackTrace) {}

  Widget onLoading() => const BusyShimmer();
}
