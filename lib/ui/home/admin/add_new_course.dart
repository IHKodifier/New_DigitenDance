import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/home/admin/new_course.dart';

class NewCourse extends ConsumerWidget {
  const NewCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NewCourseBody();
  }
}