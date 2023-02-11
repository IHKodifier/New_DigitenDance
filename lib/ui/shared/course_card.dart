// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/apis/db_course.dart';
import 'package:new_digitendance/app/states/session_state.dart';

import '../../app/models/course.dart';
import 'dart:math' as math;

import '../../app/states/admin_state.dart';
import '../courses/course_details_page.dart';

class CourseCard extends ConsumerWidget {
  CourseCard({required this.course, Key? key}) : super(key: key);

  final Course course;
  final log = Logger(printer: PrettyPrinter());
  late CourseNotifier notifier;
  late Size size;
  double tileWidth = 150;    

  Positioned buildIdPositioned(BuildContext context) {
    return Positioned(
      left: 3,
      top: 2,
      right: 3,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            decoration:  BoxDecoration(
              // color: Colors.black87,
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: buildIdText(context),
          ),
        ],
      ),
    );
  }

  Padding buildIdText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Text(
        course.id!,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w900, fontSize: 22, 
            color:Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }

  Widget buildCredits(BuildContext context) {
    return Text(
      '${course.credits.toString()} credits',
      style: Theme.of(context).textTheme.caption?.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
    );
  }

  Positioned buildTitle(BuildContext context) {
    return Positioned(
      top: 50,
      left: 8,
      // height: 100,
      // bottom: 8.0,
      child: Row(
        children: [
          FittedBox(
            child: Text(
              course.title!,
              softWrap: false,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
                  // ?.copyWith(fontWeight: FontWeight.w700,
                  // color: Theme.of(context).colorScheme.onPrimary,
                  // ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRegistrationCount(BuildContext context) {
    return Positioned(
        // top: 100,
        bottom: 0,
        left: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                '${course.preReqs!.length.toString()} Pre-Requisites',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.deepPurple, fontSize: 14,fontWeight: FontWeight.w800),
              ),
            ),
            buildCredits(context),
          ],
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    notifier = ref.read(currentCourseProvider.notifier);
    ref.listen(currentCourseProvider, (Course? previous, Course next) {
      // log.i('Listen hit fetchxxx');
      if (previous!=next) {
        ///refresh sessions
        log.i('WE HAVE DETECTEd  A CHANGE IN SELECTED  fetchxxx COURSE (from              ${previous!.id}              to          ${next.id} ');
        log.i('the new current course is ${ref.read(currentCourseProvider).id}');
       ref.invalidate(sessionStreamProvider);
       ref.read(sessionStreamProvider);
       
        
      } else {
        //do nothing
      log.i('did nothing fetchxxx');
      }
     });
  
    size = MediaQuery.of(context).size;
    log.i(course.toString());
    // Color bgColor = randomColor.randomColor(
    //   colorBrightness: ColorBrightness.light,
    //   colorSaturation: ColorSaturation.highSaturation,
    // );
    var width = MediaQuery.of(context).size.width;
    if (width > 800) {
      tileWidth = 250;
    } else {
      tileWidth = 150;
    }

    return InkWell(
      onTap: () async {
        notifier.setCurrentCourse(course);
        ref.refresh(sessionStreamProvider);
        // notifier.attachSessionsToCourse( ref.watch(sessionStreamProvider).value!);
        
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CourseDetailsPage()));
      },
      hoverColor: Theme.of(context).colorScheme.onPrimaryContainer,
      child: Container(
        width: tileWidth,
        decoration: BoxDecoration(
            color:Theme.of(context).colorScheme.primary,
                
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.inversePrimary, Theme.of(context).primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        height: 150,
        child: Stack(
          children: [
            buildIdPositioned(context),
            buildTitle(context),
            buildRegistrationCount(context),
          ],
        ),
      ),
    );
  }
}
