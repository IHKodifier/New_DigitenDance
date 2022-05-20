import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/home/admin/add_new_course.dart';
import 'package:new_digitendance/ui/home/admin/course_card.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';

import '../../../app/models/course.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(allCoursesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digitendance > Courses'),
        // centerTitle: true,
      ),
      body: courses.when(
        data: (data) => CoursesList(data: data.toList()),
        error: (e, st, ) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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

class CoursesList extends StatelessWidget {
  const CoursesList({Key? key, required this.data}) : super(key: key);
  final List<Course> data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .75,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 8),
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // final course = Course.fromMap(
                //     data[index], 
                    // data.docs[index].reference,
                    // );
                return CourseCard(
                  course: data[index],
                );
              }),
        ),
      ),
    );
  }
}
