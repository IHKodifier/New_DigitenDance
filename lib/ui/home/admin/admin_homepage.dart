
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:new_digitendance/ui/authentication/login/login_page.dart';
import 'package:new_digitendance/ui/courses/courses_page.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

import '../../../app/states/auth_state.dart';
import '../../../app/states/authentication_notifier.dart';
import '../../../app/states/institution_state.dart';
import '../../../app/states/startup_state.dart';
import '../faculty/faculty_page.dart';
 final themeModeProvider =
      StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
    return ThemeModeNotifier(ThemeMode.system);
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
    final brightnessNotifier = ref.watch(themeModeProvider.notifier);
    AuthenticationNotifier authNotifier =
        thisRef.read(authenticationNotifierProvider.notifier);
    thisRef = ref;
    _context = context;
    var asyncInstitution = ref.watch(institutionNotifierProvider);
    var appBar = AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  brightnessNotifier.toggleBrightness(context);
                },
                icon: const Icon(Icons.dark_mode)),
            const SizedBox(
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
        );
    

    return asyncInstitution.when(
      data: (institution) {
        var institutionTitle = Padding(
                  padding: const EdgeInsets.all(28),
                  child: Text(
                    institution.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                );
        
        var menuWrap = Wrap(
                    alignment: WrapAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                       HomeMenuCard(
                        iconData: Icons.auto_stories,
                        title: 'Courses',
                        onTap: (){ 
                           Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CoursesPage()));
        },
                      ),
                       HomeMenuCard(
                        // assetName: 'student.jpg',
                        iconData: Icons.people,
                        title: 'Students',
                        onTap: (){  Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CoursesPage()));
        },
                      ),
                       HomeMenuCard(
                        // assetName: 'faculty.png',
                        iconData: Icons.school,
                        title: 'Faculty',
                        onTap: (){  Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FacultyPage()));
        },
                      ),
                       HomeMenuCard(
                        // assetName: 'about.png',
                        iconData: Icons.info,
                        title: 'About Digitendance',
                        onTap: (){  Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CoursesPage()));
        },
                      ),
                       HomeMenuCard(
                        // assetName: 'settings.png',
                        iconData: Icons.settings,
                        title: 'Settings',
                                     onTap: (){  Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FacultyPage()));
        },
                      ),
                       HomeMenuCard(
                        // assetName: 'reports.jpg',
                        iconData: Icons.bar_chart_sharp,
                        title: 'Reports',
                                     onTap: (){  Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FacultyPage()));
        },
                      ),
                    ],
                  );
        var logOutButton = Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
                      onPressed: () {
                        authNotifier.signOut();
                      },
                      child: const Text('Log out ',style: TextStyle(fontSize: 20),)),
        );
        return Scaffold(
        appBar: appBar,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                institutionTitle,
                const SizedBox(
                  height: 20,
                  width: 150,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: menuWrap,
                ),
                const SizedBox(
                  height: 20,
                  width: 150,
                ),
                logOutButton,
              ],
            ),
          ),
        ),
      );
      },
      error: (e, st) => Center(child: Text(e.toString())),
      loading: () => Center(
          child: AdminFullPageShimmer(
        count: 4,
      )),
    );

  }
}

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(ThemeMode state) : super(state);

  void toggleBrightness(BuildContext context) {
    if (state == ThemeMode.light) {
     
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }



  }
}

class HomeMenuCard extends StatelessWidget {
  final VoidCallback onTap;
  const HomeMenuCard({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.title,
  }) : super(key: key);
      

  // final String assetName;
  final IconData iconData;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      margin: const EdgeInsets.all(8),
      height: 220,
      child: InkWell(
        onTap: onTap,
        // () {
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (context) => CoursesPage()));
        // },
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
                width: 100,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
