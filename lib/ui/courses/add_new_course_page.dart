import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/new_course_form.dart';
import 'package:new_digitendance/ui/home/admin/admin_homepage.dart';

import '../../app/models/course.dart';
import '../home/admin/state/admin_state.dart';

class NewCourse extends ConsumerWidget {
  const NewCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var brightnessNotifier = ref.watch(themeBrightnessProvider.notifier);
    var preLoadedState = ref.read(currentCourseProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Course'),
        actions: [
          IconButton(
              onPressed: () {
                brightnessNotifier.toggleBrightness(context);
              },
              icon: const Icon(Icons.dark_mode)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Text('Add Course',
                style: Theme.of(context).textTheme.headline3),
          ),
          const Expanded(
            child: NewCourseForm(),
            flex: 6,
          ),
        ],
      ),
    );
  }
}
