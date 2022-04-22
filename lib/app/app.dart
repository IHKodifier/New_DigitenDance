import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../ui/authentication/startup/startup_view.dart';

import '../ui/shared/shimmers.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future _initializeApp =  Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digitendance 1.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: FutureBuilder(
        future: _initializeApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SelectableText('error ${snapshot.error.toString()}'),
            );
          } 
          if (snapshot.connectionState==ConnectionState.done){
            return StartupView();}
            return BusyShimmer();
        },
      ),
    );
  }
}
