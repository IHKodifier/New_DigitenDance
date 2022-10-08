import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
      builder: ((context, widget) => ResponsiveWrapper.builder(
            widget,
            // maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              const ResponsiveBreakpoint.resize(3200, name: 'BILLBOARD'),
            ],
          )),
      title: 'Digitendance 1.0',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     useMaterial3: true,
      //     brightness: brightnessState,
// pr
      // primarySwatch: Colors.green,
      // ),
      theme: ThemeData(
        // ),
        colorSchemeSeed: const Color.fromARGB(255, 222, 6, 238),
        brightness: brightnessState,
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
