import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/models/faculty.dart';

class SelectedFacultyCard extends ConsumerWidget {
  const SelectedFacultyCard({required this.faculty, Key? key}) : super(key: key);
  final Faculty faculty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(faculty.userId),

      ],
    );
  }
}
