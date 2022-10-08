import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_wiget.dart';
import 'package:new_digitendance/ui/courses/session_card.dart';
import 'package:new_digitendance/ui/courses/session_state.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

import '../../app/models/session.dart';
import '../shared/shimmers.dart';

class CouurseDetailsView extends ConsumerWidget {
  const CouurseDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(currentCourseProvider);
    final sessionStream = ref.watch(sessionStreamProvider);

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
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      PreReqsWidget(mode: PreReqsWidgetMode.ViewOnly),
                    ],
                  ),
                ),
                Divider(thickness: 1),
                SessionViewingCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SessionViewingCard extends ConsumerWidget {
  late BuildContext localContext;
   SessionViewingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     localContext = context;
    return ref
        .watch(sessionStreamProvider)
        .when(data: whenData, error: whenError, loading: whenLoading);
  }

  Widget whenData(
    List<Session> data,
  ) {
    return Container(
      // width: 500,
      // height: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,
          border: Border.all(
            color: Theme.of(localContext).primaryColor,
            width: 3,
          )),
      child: Wrap(
        children: 
      
          data
              .map((e) => SessionTile(
                    state: e,
                  ))
              .toList(),
        
      ),
    );
  }

  Widget whenLoading() {
    return ShimmerCard();
  }

  Widget whenError(Object error, StackTrace? stackTrace) {
    return Text(error.toString() + stackTrace.toString());
  }
}
