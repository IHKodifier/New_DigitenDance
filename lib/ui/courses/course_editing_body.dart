import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseEditingBodyWidget extends ConsumerStatefulWidget {
  const CourseEditingBodyWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourseEditingBodyWidgetState();
}

class _CourseEditingBodyWidgetState extends ConsumerState<CourseEditingBodyWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(color:Colors.deepOrange,
    width: 50,
    height: 100,);
  }
}