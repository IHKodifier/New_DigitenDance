import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/courses/faculty_selection_button.dart';
import 'package:new_digitendance/ui/courses/selected_faculty_card.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';

class FacultySelectionCard extends ConsumerWidget {
  FacultySelectionCard({Key? key}) : super(key: key);
  var _context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var faculty = ref.watch(currentCourseProvider).faculty;
    _context = context;
    return Card(
      color: Theme.of(context).canvasColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text('Course Faculty',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: 28,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900)),
                IconButton(
                    onPressed: onBrowseFaculty,
                    icon: const Icon(Icons.person_search),
                    iconSize: 80),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Column(
              children: [
                Container(),
                faculty?.userId == 'not Initialized'
                    ? Container(
                        // width: 50,
                        height: 20,
                        child: Text('Please select Faculty'),
                        color: Colors.yellow,
                      )
                    : SelectedFacultyCard(
                        faculty: faculty!,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onBrowseFaculty() {
    showDialog(context: this._context, builder: buildFacultyListDialog);
  }

  Widget buildFacultyListDialog(BuildContext context) {
    return SimpleDialog(
      children: [
        Text('Hello'),
        Text('Hello'),
        Text('Hello'),
      ],
    );
  }
}
