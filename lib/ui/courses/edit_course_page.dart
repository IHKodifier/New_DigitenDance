import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/course_editing_body.dart';

import '../home/admin/state/admin_state.dart';

class EditCoursePage extends ConsumerWidget {
  const EditCoursePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(currentCourseProvider.notifier);
    final state = ref.watch(currentCourseProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('Editing  ${state.id}'),
          centerTitle: true,
        ),
        body: const CourseEditingBodyWidget());
  }
}