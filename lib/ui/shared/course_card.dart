import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:random_color/random_color.dart';

import '../../app/models/course.dart';
import 'dart:math' as math;

class CourseCard extends ConsumerWidget {
  CourseCard({required this.course, Key? key}) : super(key: key);

  final Course course;
  RandomColor randomColor = RandomColor();
  late Size size;
    double tileWidth = 150;

  Positioned buildIdPositioned(BuildContext context) {
    return Positioned(
      
      left: (tileWidth/2)-20,
      top: 0,
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

  Positioned buildCredits(BuildContext context) {
    return Positioned(
        bottom: 4,
        right: 4,
        child: Container(
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '${course.credits.toString()}',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.yellow,
                      ),
                ),
              Icon(Icons.donut_small_outlined,
              color: Colors.yellow,),
              ],
            ),
          ),
        ));
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
        top: 100,
        left: 0,
        child: Text(' PRE-REQUISITES: ${course.preReqs!.length.toString()}'));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var log = Logger(printer: PrettyPrinter());
    size = MediaQuery.of(context).size;
    log.i(course.toString());
    Color bgColor = randomColor.randomColor(
      colorBrightness: ColorBrightness.light,
    );
    var width = MediaQuery.of(context).size.width;
if (width>800) {tileWidth= 250;
  }else {
  tileWidth=150;
}





    
    return Container(
      width: tileWidth,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius:  BorderRadius.circular(
          // topRight: Radius.circular(30),
          // bottomLeft: Radius.circular(30),
          30
        ),
      ),
      height: 150,
      child: Stack(
        children: [
          buildIdPositioned(context),
          buildTitle(context),
          buildCredits(context),
          buildRegistrationCount(context),
        ],
      ),
    );
  }
}
