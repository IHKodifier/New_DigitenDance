import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/pre_reqs.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

class PreReqsEditor extends ConsumerWidget {
  const PreReqsEditor({Key? key}) : super(key: key);

  preReqsTitle(BuildContext context) => Text(
        'Course Pre-Requisites',
        style: Theme.of(context).textTheme.headline4,
      );

  preReqsHint(BuildContext context) => Text(
        'Tap on a Course to Add/Remove',
        style: Theme.of(context).textTheme.headline5,
      );

  preReqsCount(BuildContext context, PreReqsEditingState state) => Text(
        'Selected Pre-Requisites (${state.selectedPreReqs?.length.toString()})',
        style: Theme.of(context).textTheme.headline5,
      );

  Widget availableGrid(BuildContext context, PreReqsEditingState state,
      PreReqsEditingNotifier notifier) {
    return SizedBox(
      height: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        children: state.availablePreReqs
            .map((e) => availablePreReqCard(notifier, e))
            .toList(),
      ),
    );
  }

  InkWell availablePreReqCard(PreReqsEditingNotifier notifier, PreReqs e) {
    return InkWell(
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () => notifier.addPreReq(preReq: e),
          hoverColor: Colors.green.shade200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: FittedBox(child: Text(e.id)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          e.credits.toString(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell selectedPreReqCard(PreReqsEditingNotifier notifier, PreReqs e) {
    return InkWell(
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () => notifier.removePreReq(preReq: e),
          hoverColor: Colors.red.shade200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: FittedBox(child: Text(e.id)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          e.credits.toString(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectedGrid(BuildContext context, PreReqsEditingState state,
      PreReqsEditingNotifier notifier) {
    return SizedBox(
      height: 150,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        children: state.selectedPreReqs!
            .map((e) => selectedPreReqCard(notifier, e))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(preReqsEditingProvider.notifier);
    final state = ref.watch(preReqsEditingProvider);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(8),
      surfaceTintColor: Color.fromARGB(255, 242, 148, 225),
      color: Colors.white70,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            preReqsTitle(context),
            const SpacerVertical(12),
            preReqsHint(context),
            const SpacerVertical(12),
            preReqsCount(context, state),
            const SpacerVertical(12),
            Flexible(flex: 1, child: selectedGrid(context, state, notifier)),
            const SpacerVertical(12),
            Flexible(flex: 3, child: availableGrid(context, state, notifier)),
            const SpacerVertical(12),
          ],
        ),
      ),
    );
  }
}
