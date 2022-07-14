import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_state.dart';

import '../../app/models/course.dart';

class PreReqsWidget extends ConsumerWidget {
  const PreReqsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(preReqsEditingProvider);
    final notifier = ref.watch(preReqsEditingProvider.notifier);
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pre Requisites (' + state.allPreReqs.length.toString() + ')',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    state.allPreReqs.map((e) => _buildChip(e, context)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(Course e, BuildContext context) {
    return Theme(
      
      data: ThemeData.dark(),
      child: ActionChip(
        elevation: 10,
        labelPadding: const EdgeInsets.all(8),
        // backgroundColor: Colors.white,
        // avatar: CircleAvatar(
        //   backgroundColor: Theme.of(context).colorScheme.background,
        //   minRadius: 200,
        //   // radius: 250,
        //   child: Padding(
        //     padding: const EdgeInsets.all(4.0),
        //     child: FittedBox(
        //       child: Text(
        //         e.courseId!,
        //         style: const TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //   ),
        // ),
        label: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            Padding(
              padding: 
              const EdgeInsets.all(4.0),
            child: FittedBox(
              child: Text(
                e.courseId,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left:4,right:4,bottom:4.0),
              child: Text(
                e.courseTitle,
                style:  TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ],
        ),
        onPressed: () {
          // action(e);
        },
      ),
    );
  }
}
