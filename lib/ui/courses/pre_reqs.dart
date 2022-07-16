import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

import '../../app/models/course.dart';

class PreReqsWidget extends ConsumerWidget {
  const PreReqsWidget({Key? key}) : super(key: key);

  Widget buildChip(Course e, BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: (MediaQuery.of(context).size.width - 40) / 3),
      child: PreReqsActionChip(
        e: e,
        action: ref.read(preReqsEditingProvider.notifier).addPreReq,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(preReqsEditingProvider.notifier);

    notifier.getAllPreReqs();
    final state = ref.watch(preReqsEditingProvider);
    return SizedBox(
      width: double.infinity,
      child: Material(
        type: MaterialType.canvas,
        shadowColor: Colors.black,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const PreReqsTitle(),
            const PreReqsHint(),
            Flexible(
              fit: FlexFit.loose,
              // margin: EdgeInsets.all(10),
              // height: 100,
              // padding: const EdgeInsets.all(16),
              // color: Colors.blueGrey.shade100,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: state.availablePreReqs
                    .map((e) => buildChip(e, context, ref))
                    .toList(),
              ),
            ),
            const SpacerVertical(40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              // height: 200,
              // decoration: BoxDecoration(
              //   border: Border.all(width: 3, color: Colors.purple),
              // ),
              child: Material(
                //  
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpacerVertical(10),
                    Flexible(
                      // flex:0,
                      fit: FlexFit.loose,
                      child: state.selectedPreReqs!.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'No Pre Requisites have been added',
                                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 28),
                                  ),
                                  Text(
                                    'Tap on a course to Add/Remove as a Pre requisite',
                                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 28),
                                  ),
                                ],
                              ),
                            )
                          : SelectedPreReqsWrap(state, ref),
                    ),
                  ],
                ),
              ),
            ),
            const SpacerVertical(20),
          ],
        ),
      ),
    );
  }
}

class PreReqsActionChip extends StatelessWidget {
  final Course e;
  final Function action;
  const PreReqsActionChip({
    Key? key,
    required this.e,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      elevation: 10,
      labelPadding: const EdgeInsets.all(8),
      backgroundColor: Colors.white,
      avatar: CircleAvatar(
        backgroundColor: Theme.of(context).cardColor,
        minRadius: 200,
        // radius: 250,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            e.courseId,
            style: const TextStyle(
              // fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              // backgroundColor: Colors.black87.withOpacity(0.5),
            ),
          ),
        ),
      ),
      label: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
              child: Text(
                e.courseTitle,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4.0),
            child: Wrap(
              children: [
                Text(
                  e.credits.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black87),
                ),
                Text(
                  ' credits',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: () {
        action(e);
      },
      labelStyle: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class SelectedPreReqsWrap extends StatelessWidget {
  final PreReqsEditingState state;
  final WidgetRef ref;

  const SelectedPreReqsWrap(this.state, this.ref);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Added Pre-Requites (${ref.watch(preReqsEditingProvider).selectedPreReqs?.length.toString()})',style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: state.selectedPreReqs!
                  .map(
                    (e) => PreReqsActionChip(
                      e: e,
                      action: ref.read(preReqsEditingProvider.notifier).removePreReq,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PreReqsHint extends ConsumerWidget {
  const PreReqsHint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Available Pre-Requites to choose from ',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color: Theme.of(context).primaryColor)),
          Text(' (${ref.watch(preReqsEditingProvider).availablePreReqs.length.toString()})' ,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class PreReqsTitle extends StatelessWidget {
  const PreReqsTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Course Pre Requisites ',
        // state.allPreReqs.length.toString() +
        // ')',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 28, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
