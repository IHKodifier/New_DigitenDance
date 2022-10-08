import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/models/session.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({Key? key, required this.state}) : super(key: key);
  final Session state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(state.sessionId!),
    );
  }
}
