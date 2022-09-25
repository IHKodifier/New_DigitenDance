import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/pre_reqs.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

class PreReqsEditor extends ConsumerWidget {
  const PreReqsEditor({Key? key}) : super(key: key);

  Widget availableGrid(BuildContext context, PreReqsEditingState state,
      PreReqsEditingNotifier notifier) {
    return SizedBox(
      height: 100,
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        children: state.availablePreReqs
            .map((e) => availablePreReqCard(notifier, e))
            .toList(),
      ),
    );
  }

  Widget selectedGrid(BuildContext context, PreReqsEditingState state,
      PreReqsEditingNotifier notifier) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          // color: Colors.green.shade200,
          elevation: 15,
          shadowColor: Colors.black87,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            children: state.selectedPreReqs!
                .map((e) => selectedPreReqCard(context, notifier, e))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget availablePreReqCard(PreReqsEditingNotifier notifier, PreReqs e) {
    return Wrap(
      children: [
        Card(
          elevation: 5,
          child: InkWell(
            onTap: () => notifier.addPreReq(preReq: e),
            hoverColor: Colors.green.shade200,
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectedPreReqCard(
      context, PreReqsEditingNotifier notifier, PreReqs e) {
    return Wrap(
      children: [
        InkWell(
          onTap: () => notifier.removePreReq(preReq: e),
          hoverColor: Colors.red.shade200,
          child: Stack(
            children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: ClipOval(
                child: Container(
                  color: Colors.green.shade200,
                  child: Icon(
                    Icons.done,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  ),
                ),
              ),
            ),
            Padding(
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
            ),
          ], 
          clipBehavior: Clip.none,
          
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(preReqsEditingProvider.notifier);
    final state = ref.watch(preReqsEditingProvider);
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(8),
      surfaceTintColor: const Color.fromARGB(255, 242, 148, 225),
      color: Colors.white70,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PreReqsTitle(),
            const SpacerVertical(12),
            const PreReqsCount(),
            const SpacerVertical(12),
            state.selectedPreReqs!.isEmpty
                ? const PreReqsHint()
                : Flexible(
                    flex: 1,
                    child: selectedGrid(context, state, notifier),
                    fit: FlexFit.loose,
                  ),
            const SpacerVertical(12),
            Flexible(
              flex: 1,
              child: availableGrid(context, state, notifier),
              fit: FlexFit.loose,
            ),
            const SpacerVertical(12),
          ],
        ),
      ),
    );
  }
}

class PreReqsTitle extends StatelessWidget {
  const PreReqsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Course Pre-Requisites',
        style: Theme.of(context).textTheme.headline3?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}

class PreReqsCount extends ConsumerWidget {
  const PreReqsCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(preReqsEditingProvider);
    return Text(
      '${state.selectedPreReqs?.length.toString()} Pre-Requisites selected',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).primaryColor,
          ),
    );
  }
}

class PreReqsHint extends ConsumerWidget {
  const PreReqsHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(preReqsEditingProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Tap on a preRequisite to add /remove',
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Colors.blueGrey.shade800,
            ),
      ),
    );
  }
}
