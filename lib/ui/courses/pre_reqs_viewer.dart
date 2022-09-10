import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/models/pre_reqs.dart';

class PreReqsViewer extends ConsumerWidget {
  PreReqsViewer({Key? key}) : super(key: key);

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
        builder: (_) => AlertDialog(
              title: Text('cant do that '),
            ));
  }

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      return Container();
    }
}
