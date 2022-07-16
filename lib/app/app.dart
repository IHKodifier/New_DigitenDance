import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/contants.dart';
import '../ui/authentication/startup/startup_view.dart';
import '../ui/home/admin/admin_homepage.dart';

import '../ui/shared/shimmers.dart';

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  final Future _initializeApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightnessNotifier = ref.read(themeBrightnessProvider.notifier);
    var brightnessState = ref.watch(themeBrightnessProvider);
    return MaterialApp(
      title: 'Digitendance 1.0',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     useMaterial3: true,
      //     brightness: brightnessState,
// pr
          // primarySwatch: Colors.green,
          // ),
      theme: ThemeData.from(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          brightness: brightnessState,
          primary: Color.fromARGB(249, 33, 102, 4),
          secondary: const Color.fromARGB(249, 22, 69, 3),
          tertiary: Color.fromARGB(248, 112, 3, 121),
          // onPrimary: Color.fromARGB(248, 157, 228, 115),
          onSurface: const Color.fromARGB(248, 27, 70, 1),
          background: const Color.fromARGB(248, 238, 239, 237),
          surface: const Color.fromARGB(169, 131, 181, 82),
          
        ),
        
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _initializeApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SelectableText('error ${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StartupView();
          }
          return const ShimmerCard();
        },
      ),
    );
  }
}
