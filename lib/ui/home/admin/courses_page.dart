import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';
import 'package:new_digitendance/ui/home/admin/add_new_course.dart';
import 'package:new_digitendance/ui/home/admin/course_card.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

import '../../../app/models/course.dart';

class CoursesPage extends ConsumerWidget {
  CoursesPage({Key? key}) : super(key: key);
  var log = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digitendance > Courses'),
        // centerTitle: true,
      ),
      body: CoursesList(),
      floatingActionButton: FloatingActionButton.extended(
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

  navigateToAddCourse(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NewCourse()));
  }
}

class CoursesList extends ConsumerWidget {
  CoursesList({Key? key}) : super(key: key);
  var log = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.i('feteching courses stream');
    log.i(ref.read(institutionNotifierProvider));
    // final courses = ref.watch(allCoursesStreamProvider);
    // log.i(courses.asData?.value.toString);
    ref.read(institutionNotifierProvider);

    final coursesList = ref.watch(allCoursesStreamProvider);
    // log.i(message)
    return coursesList.when(
        data: (courseIterable) {
          final coursesLists = courseIterable.toList();
          return ListView.builder(
            itemCount: coursesLists.length,
            itemBuilder: (context, index) {
              // final course = Course.fromMap(
              //     data[index],
              // data.docs[index].reference,
              // );
              return CourseCard(
                course: coursesLists[index],
              );
            },
          );
        },
        error: (err, st) {
          log.e(err.toString() + st.toString());
          return Center(child: Text(err.toString() + st.toString()));
        },
        loading: () => const BusyShimmer());
  }
}
