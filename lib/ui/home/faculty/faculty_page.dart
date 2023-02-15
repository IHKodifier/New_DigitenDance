import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/faculty.dart';
import 'package:new_digitendance/app/states/faculty_state.dart';
import 'package:new_digitendance/ui/home/faculty/new_faculty_form.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

class FacultyPage extends ConsumerWidget {
  FacultyPage({super.key});
  late BuildContext _context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
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
          padding: EdgeInsets.all(8),
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
                data: (data) => onData(data),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onData(List<Faculty> data) {
    return [
      Container(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                    context: _context,
                    builder: (context) => const NewFacultyForm());
              },
              icon: Icon(Icons.add, size: 60),
              label: Text(
                'New Faculty',
                style: Theme.of(_context).textTheme.titleMedium,
              )),
        ),
      ),
      Container(
        width: double.infinity,
        child: Wrap(
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: data
              .map((e) => Container(
                    width: 400,
                    height: 140,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(
                              Icons.account_circle,
                              size: 100,
                            ),
                            Container(
                              height: 108,
                              // color: Colors.blue,

                              child: Center(child: Text(e.prefix!))),
                              Center(child: Text(' ${e.firstName!}')),
                              Center(child: Text('${ e.lastName!}')),
                          ]),
                          Text(e.jobTitle!),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    ];
  }
}
