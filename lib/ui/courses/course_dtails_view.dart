import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_wiget.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

class CouurseDetailsView extends ConsumerWidget {
  const CouurseDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(currentCourseProvider);

    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Material(
          elevation: 20,
          shadowColor: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.auto_stories,
                      size: 130,
                    ),

                    Text(
                      state.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      '${state.credits.toString()} credits',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    //  Expanded(
                    //   child: Container(),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Course Pre-Requisites (${state.preReqs?.length.toString()} )',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Theme.of(context).primaryColor),
                        ),
                      ),
                      PreReqsWidget(mode: PreReqsWidgetMode.ViewOnly),
                    ],
                  ),
                ),
                Divider(thickness:1 ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sessions (${state.sessions?.length.toString()} )',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(64.0),
                        child: Text(
                          state.description==''? 'NA':state.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
