import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_editor.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_viewer.dart';

enum PreReqsWidgetMode { Editable, ViewOnly }

class PreReqsWidget extends ConsumerWidget {
  final PreReqsWidgetMode mode;
  const PreReqsWidget({required this.mode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return mode == PreReqsWidgetMode.ViewOnly
        ? PreReqsViewer()
        : PreReqsEditor();
  }
}
