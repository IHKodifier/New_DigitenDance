import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';
import 'package:new_digitendance/ui/courses/add_new_course_page.dart';
import 'package:new_digitendance/ui/home/admin/admin_homepage.dart';
import 'package:new_digitendance/ui/shared/course_card.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

class CoursesPage extends ConsumerWidget {
  CoursesPage({Key? key}) : super(key: key);

  var log = Logger(printer: PrettyPrinter());

  navigateToAddCourse(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NewCourse()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var brightnessNotifier = ref.read(themeBrightnessProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digitendance > Courses'),
        actions: [
          
          IconButton(
              onPressed: () {
                brightnessNotifier.toggleBrightness(context);
              },
              icon: const Icon(Icons.dark_mode)),
          SizedBox(
            width: 40,
          ),
        ],
        // centerTitle: true,
      ),
      body: CoursesList(),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          ref.refresh(institutionNotifierProvider);
          final courseNotifier = ref.watch(currentCourseProvider.notifier);
          navigateToAddCourse(context);
        },
        label: Text(
          'New Course',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white,
                // fontFamily: Goog¿,
                fontSize: 22,
              ),
        ),
        icon: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      // floatingActionButtonLocation:
      // FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

class CoursesList extends ConsumerWidget {
  CoursesList({Key? key}) : super(key: key);

  var log = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//TODO paste ref.listen code here
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
    //       ref.read(institutionNotifierProvider.notifier).setDocRefOnInstitution(
    //           appUser.docRef!.parent.parent
    //               as DocumentReference<Map<String, dynamic>>);
    //     });
    //   }
    // });

    log.i(
        'feteching courses stream from ${ref.read(institutionNotifierProvider).value?.docRef?.path}');

    final courseStream = ref.watch(allCoursesStreamProvider);
    return courseStream.when(
      error: (err, st) {
        log.e(err.toString() + st.toString());
        return Center(
          child: Text(
            err.toString() + st.toString(),
          ),
        );
      },
      loading: () => Center(child: AdminFullPageShimmer(count: 4)),
      data: (courses) {
        log.i('length of courses ${courses.length.toString()}');
        return ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return CourseCard(
              course: courses[index],
            );
          },
        );
      },
    );
  }
}
