import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/models/course.dart';
import 'package:new_digitendance/app/models/institution.dart';
import 'package:new_digitendance/app/utilities.dart';
import 'package:new_digitendance/ui/authentication/login/login_page.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';
import 'package:new_digitendance/ui/courses/courses_page.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

import '../../authentication/startup/state/startup_state.dart';
import '../../authentication/state/auth_state.dart';
import '../../authentication/state/authentication_notifier.dart';
import 'state/admin_state.dart';
  final themeBrightnessProvider =
      StateNotifierProvider<BrightnessNotifier, Brightness>((ref) {
    return BrightnessNotifier(Brightness.light);
  });
class AdminAppHomePage extends ConsumerWidget {
  AdminAppHomePage({Key? key}) : super(key: key);

  var log = Logger(printer: PrettyPrinter());
  var thisRef;

  late BuildContext _context;



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    thisRef = ref;
    // final allAdminCourses = ref.watch(allCoursesStreamProvider);
    final startupNotifier = ref.read(startupStateNotifierProvider.notifier);
    final brightnessNotifier = ref.watch(themeBrightnessProvider.notifier);
    AuthenticationNotifier authNotifier =
        thisRef.read(authenticationNotifierProvider.notifier);
    thisRef = ref;
    _context = context;
    var asyncInstitution = ref.watch(institutionNotifierProvider);
    // Theme.of(context).copyWith(brightness: brightnessNotifier.state);

    // ref.listen<StartupState>(startupStateNotifierProvider,
    //     (StartupState? previous, StartupState next) {
    //   int x;
    //   x = 2;

    //   if (next.hasAuthentiatedUser) {
    //     ref
    //         .read(authenticationNotifierProvider.notifier)
    //         .grabAppUserFromDb(next.currentFirebaseUser!)
    //         .then((appUser) {
    //       log.d(
    //           'Detected existing user and now\n Grabbing AppUser from DB ${appUser.toString()}');
    //       ref
    //           .read(authenticationNotifierProvider.notifier)
    //           .setAuthenticatedUser(appUser: appUser);
    //       ref.read(institutionNotifierProvider.notifier).setDocRefOnInstitution(appUser
    //           .docRef!
    //           .parent
    //           .parent as DocumentReference<Map<String, dynamic>>);
    //     });
    //   }
    // });

    return asyncInstitution.when(
      data: (institution) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  brightnessNotifier.toggleBrightness(context);
                },
                icon: const Icon(Icons.dark_mode)),
            SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {
                // AuthenticationNotifier notifier =
                //     thisRef.read(authenticationNotifierProvider.notifier);
                authNotifier.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => const LoginPage())));
              },
              icon: const Icon(Icons.logout),
              iconSize: 40,
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Text(
                    institution.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const HomeMenuCard(
                        iconData: Icons.auto_stories,
                        title: 'Courses',
                      ),
                      const HomeMenuCard(
                        // assetName: 'student.jpg',
                        iconData: Icons.people,
                        title: 'Students',
                      ),
                      const HomeMenuCard(
                        // assetName: 'faculty.png',
                        iconData: Icons.school,
                        title: 'Faculty',
                      ),
                      const HomeMenuCard(
                        // assetName: 'about.png',
                        iconData: Icons.info,
                        title: 'About Digitendance',
                      ),
                      const HomeMenuCard(
                        // assetName: 'settings.png',
                        iconData: Icons.settings,
                        title: 'Settings',
                      ),
                      const HomeMenuCard(
                        // assetName: 'reports.jpg',
                        iconData: Icons.bar_chart_sharp,
                        title: 'Reports',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      authNotifier.signOut();
                    },
                    child: const Text('Log out ')),
              ],
            ),
          ),
        ),
      ),
      error: (e, st) => Center(child: Text(e.toString())),
      loading: () => Center(
          child: AdminFullPageShimmer(
        count: 4,
      )),
    );

  }
}

class BrightnessNotifier extends StateNotifier<Brightness> {
  BrightnessNotifier(Brightness state) : super(state);

  void toggleBrightness(BuildContext context) {
    if (state == Brightness.light) {
      // state = Brightness.dark;
      var newState = state;
      newState = Brightness.dark;
      state = newState;
      // Theme.of(context).copyWith(brightness: Brightness.dark);
    } else {
      // state = Brightness.light;
      var newState = state;
      newState = Brightness.light;
      state = newState;
      // state = Brightness.light;




      // Theme.of(context).copyWith(brightness: Brightness.light);
    }
  }
}

class HomeMenuCard extends StatelessWidget {
  const HomeMenuCard({Key? key, required this.iconData, required this.title})
      : super(key: key);

  // final String assetName;
  final IconData iconData;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.20,
        margin: const EdgeInsets.all(8),
        height: 220,
        child: InkWell(
          // hoverColor: Colors.purple.shade300,
          // splashColor: Colors.purple.shade100,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CoursesPage()));
          },
          child: Card(
            // shape: Bordersh(),
            elevation: 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Theme.of(context).iconTheme.color,
                  size: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
