import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/states/institution_state.dart';
import 'package:new_digitendance/ui/courses/add_new_course_page.dart';
import 'package:new_digitendance/ui/home/admin/admin_homepage.dart';
import 'package:new_digitendance/ui/shared/course_card.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

import '../../app/states/admin_state.dart';

class CoursesPage extends ConsumerWidget {
  CoursesPage({Key? key}) : super(key: key);

  var log = Logger(printer: PrettyPrinter());

  navigateToAddCourse(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NewCourse()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var brightnessNotifier = ref.read(themeModeProvider.notifier);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.refresh(institutionNotifierProvider);
          final courseNotifier = ref.watch(currentCourseProvider.notifier);
          navigateToAddCourse(context);
        },
     
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),

    );
  }
}

class CoursesList extends ConsumerWidget {
  CoursesList({Key? key}) : super(key: key);

  var log = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    log.i(
        'feteching courses stream from ${ref.read(institutionNotifierProvider).value?.docRef?.path}');

    final courseStream = ref.watch(allCoursesStreamProvider);
    return courseStream.when(
      error: (err, st) {
        log.i(err.toString() + st.toString());
        return Center(
          child: Text(
            err.toString() + st.toString(),
          ),
        );
      },
      loading: () => Center(child: AdminFullPageShimmer(count: 4)),
      data: (courses) {
        log.i('length of courses ${courses.length.toString()}');
        
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0),
              child: Wrap(
                runAlignment: WrapAlignment.center,
                runSpacing: 48,
                spacing: 48,
                children: courses.map((e) => CourseCard(course: e))
                .toList(),
                  ),
            ),
          ),
        );
      },
    );
  }
}
