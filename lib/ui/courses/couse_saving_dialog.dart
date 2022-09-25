import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../app/models/course.dart';

final courseSavingIsBuyProvider = Provider<bool>((ref) {
  return true;
});

class CourseSavingDialog extends ConsumerWidget {
  final Course course;
  // bool isBusy = true;
  CourseSavingDialog({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isBusy=ref.watch(courseSavingIsBuyProvider);
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 4,
        child: AlertDialog(
          actionsPadding: EdgeInsets.all(8),
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            'Creating new Course',
            style: Theme.of(context).textTheme.headline3,
          ),
          content: Center(
            child: isBusy ? const CircularProgressIndicator() : Container(child: Lottie.network('https://assets5.lottiefiles.com/private_files/lf30_nrnx3s.json'),),
          ),
          // actions: [
          //   Container(
          //     width: double.infinity,
          //     height: 60,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //         Navigator.of(context).pop();
          //       },
          //       child: Text('DONE'),
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
