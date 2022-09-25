import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import 'package:random_color/random_color.dart';

import '../../app/models/course.dart';
import 'dart:math' as math;

import '../courses/course_details_page.dart';

class CourseCard extends ConsumerWidget {
  CourseCard({required this.course, Key? key}) : super(key: key);

  final Course course;
  RandomColor randomColor = RandomColor();
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
            decoration: const BoxDecoration(
              color: Colors.black87,
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
        course.id,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w900, fontSize: 22, color: Colors.yellow),
      ),
    );
  }

  Widget buildCredits(BuildContext context) {
    return Text(
      '${course.credits.toString()} credits',
      style: Theme.of(context).textTheme.caption?.copyWith(
            color: Colors.yellow,
            fontSize:16,
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
              course.title,
              softWrap: false,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
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
              child: Text('${course.preReqs!.length.toString()} Pre-Requisites',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.white,
                fontSize: 14
              ),),
            ),


            buildCredits(context),
          ],
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var log = Logger(printer: PrettyPrinter());
    size = MediaQuery.of(context).size;
    log.i(course.toString());
    Color bgColor = randomColor.randomColor(
      colorBrightness: ColorBrightness.light,
      colorSaturation: ColorSaturation.highSaturation,
    );
    var width = MediaQuery.of(context).size.width;
    if (width > 800) {
      tileWidth = 250;
    } else {
      tileWidth = 150;
    }

    return InkWell(
      onTap: () {
        ref.read(currentCourseProvider.notifier).setCurrentCourse(course);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CourseDetailsPage()));
      },
      hoverColor: Theme.of(context).primaryColor,
      child: Container(
        width: tileWidth,
        decoration: BoxDecoration(
          color: randomColor.randomColor(
            colorBrightness: ColorBrightness.light
          ),
          borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [randomColor.randomColor(),Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter)
        ),
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
