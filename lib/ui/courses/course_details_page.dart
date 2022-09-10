import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/course_details_body.dart';
import 'package:new_digitendance/ui/courses/edit_course_page.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';

class CourseDetailsPage extends ConsumerWidget {
  CourseDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final course = ref.watch(currentCourseProvider);
    String appBarTitle = course.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: CourseDetailsBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const EditCoursePage()));
        },
        icon: Icon(Icons.edit),
        label: Text(
          'Edit Course',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white,
                // fontFamily: Goog¿,
                fontSize: 22,
              ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
