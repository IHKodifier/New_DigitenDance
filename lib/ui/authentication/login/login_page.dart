import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';
import '../login/login_form.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  get svgChild => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'school.svg',
          // height: 300,
          // width: 800,
          // color: Theme.of(context).primaryColor,
          fit: BoxFit.contain,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .7,
        margin: EdgeInsets.all(32),
        child: Material(
          // color: Colors.purple.shade50,
          elevation: 50,
          // shadowColor: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpacerVertical(10),
              Expanded(flex: 10, child: svgChild),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: const LoginForm(),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
