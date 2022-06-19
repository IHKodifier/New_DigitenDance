import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../app/models/course.dart';

class CourseCard extends ConsumerWidget {
  const CourseCard({required this.course, Key? key}) : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var log = Logger(printer: PrettyPrinter());
    log.d(course.toString());
    
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: ListTile(
        // color: Colors.purple,
        title: Text(course.courseId!),
      ),
    );
  }
}
