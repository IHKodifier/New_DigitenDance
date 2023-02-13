import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/states/faculty_state.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

class FacultyPage extends ConsumerWidget {
  const FacultyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final facultyList = ref.watch(facultyListProvider);
    var appBar = AppBar(
      title: Text(
        'Faculty page ',
      ),
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Container(
          // color: Colors.blue,
          // width: MediaQuery.of(context).size.width * 0.95,
          margin: EdgeInsets.all(16),
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: facultyList.when(
                error: (error, stackTrace) => [Text(error.toString())],
                loading: () => [
                  ShimmerCard(),
                  ShimmerCard(),
                  // ShimmerCard(),
                  // ShimmerCard(),
                ],
                data: (data) => [
                  Wrap(
                    children: data
                        .map((e) => Container(
                              width: 400,
                              height: 120,
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.account_circle,
                                        size: 80,
                                      ),
                                      Text(e.firstName!),
                                    ]),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
