import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/models/course.dart';

class CourseCard extends ConsumerWidget {
  const CourseCard({required this.course, Key? key}) : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
