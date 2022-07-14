import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/app_services.dart';
import 'package:new_digitendance/ui/authentication/state/institution_state.dart';
import 'package:new_digitendance/ui/courses/course_notifier.dart';

import '../../app/models/course.dart';

///[selectedCourseProvider] provides inatance of currently selected [Course] managedg by [CourseNotifier]
final currentCourseProvider =
    StateNotifierProvider<CourseNotifier, Course>((ref) {
  return CourseNotifier(Course(docRef: AppServices.dbService.documentReferenceFromPath('institutions/initial'), courseId: '', courseTitle: '', credits: 0), ref);
});

