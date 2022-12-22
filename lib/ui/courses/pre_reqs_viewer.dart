import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/states/admin_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';
import 'package:random_color/random_color.dart';

import '../../app/models/course.dart';
import '../../app/models/pre_reqs.dart';
import 'edit_course_page.dart';

class PreReqsViewer extends ConsumerWidget {
  PreReqsViewer({Key? key}) : super(key: key);

  late Course state;

  late BuildContext _context;

  // Widget buildChip(PreReqs e, BuildContext context, WidgetRef ref) {
  //   _context = context;
  //   return ConstrainedBox(
  //     constraints: BoxConstraints(
  //         maxWidth: (MediaQuery.of(context).size.width - 40) / 3),
  //     child: PreReqsActionChip(
  //       e:e,
  //       onPressed:
  //           editingNotAlowedAlert,
  //     ),
  //   );
  // }

  void editingNotAlowedAlert() {
    showDialog(
        context: _context,
        builder: (_) => const AlertDialog(
              title: Text('cant do that '),
            ));
  }

  Widget noEditiDialog(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * .3,
        // height: 100,
        // color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpacerVertical(20),
            Icon(
              Icons.info_outline,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SpacerVertical(20),
            Text(' cannot modify course Pre requisites ',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    )),
            const SpacerVertical(20),
            Text(
              'Tap on Edit Course to edit prerequisites',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 20,
                  ),
            ),
            const SpacerVertical(20),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const EditCoursePage()));
                    },
                    child: Text(
                      'Edit Course',
                      style: Theme.of(context).textTheme.button?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                    )),
              ),
            ),
            const SpacerVertical(12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    state = ref.watch(currentCourseProvider);

    return Wrap(
      children: state.preReqs!
          .map((e) => Container(
                margin: const EdgeInsets.all(8),
                height: 100,
                width: 250,
                child: Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                         
                          showDialog(context: context, builder: noEditiDialog);
                        },
                        splashColor:
                            Theme.of(context).primaryColor.withOpacity(0.7),
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            width: 80,
                            height: 80,
                            color: RandomColor().randomColor(),
                            child: FittedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(e!.id),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e.title,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
