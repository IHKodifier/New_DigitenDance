import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/models/session.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({Key? key, required this.state}) : super(key: key);
  final Session state;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width/4.1,
      // color: Theme.of(context).colorScheme.inversePrimary,
      // height: 250,
      margin: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
            CircleAvatar(
              // color: Colors.red,
              radius: size.width/30,
              // width: size.height/6,
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text(state.id!))),
              ),
            Expanded(child: Container()),
             Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(state.title!,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  // color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.bold),
                
                ),
                Text(state.faculty!.jobTitle!+' '+state.faculty!.firstName!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  // color: Theme.of(context).primaryColor,
                ),),
                Text(state.registrationStartDate!.toString()),
                Text(state.title!),
              ],
                       ),
           ], ),
        ),
      ),
    );
  }
}
