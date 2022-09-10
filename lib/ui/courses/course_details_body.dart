import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_wiget.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';

import '../../app/models/course.dart';

class CourseDetailsBody extends ConsumerWidget {
  CourseDetailsBody({Key? key}) : super(key: key);
  late Course course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    course = ref.watch(currentCourseProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  course.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Theme.of(context).primaryColorDark),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${course.credits} credits',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).primaryColorDark, fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
           const PreReqsWidget(
            mode: PreReqsWidgetMode.ViewOnly,
            
          ),
          // SessionsViewerWidget(),
        ],
      ),
    );
  }
}
