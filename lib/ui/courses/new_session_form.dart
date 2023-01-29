import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/new_session_form_body.dart';

class NewSessionForm extends ConsumerWidget {
  const NewSessionForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // color: Colors.green,
      child: NewSessionFormBody());
  }
}
