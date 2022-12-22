import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/course_details_body.dart';
import 'package:new_digitendance/ui/courses/course_dtails_view.dart';
import 'package:new_digitendance/ui/courses/edit_course_page.dart';

import '../../app/states/admin_state.dart';

class CourseDetailsPage extends ConsumerWidget {
  CourseDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final course = ref.watch(currentCourseProvider);
    String appBarTitle = ' Editing  ${course.id}';
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: Column(
        children: const [
         
          // CourseDetailsBody(),
          CouurseDetailsView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const EditCoursePage()));
        },
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
