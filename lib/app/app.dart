import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
    var _breakPoints = [
      const ResponsiveBreakpoint.resize(480, name: MOBILE),
      const ResponsiveBreakpoint.autoScale(800, name: TABLET),
      const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
      const ResponsiveBreakpoint.resize(3200, name: 'BILLBOARD'),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: ((context, widget) => ResponsiveWrapper.builder(
            widget,
            minWidth: 480,
            defaultScale: true,
            breakpoints: _breakPoints,
          )),
      title: 'Digitendance 1.0',
      themeMode: ThemeMode.dark,

      theme: FlexThemeData.light(
  scheme: FlexScheme.verdunHemlock,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 9,
  tabBarStyle: FlexTabBarStyle.universal,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useFlutterDefaults: true,
    thinBorderWidth: 1.0,
    defaultRadius: 7.0,
    textButtonRadius: 11.0,
    elevatedButtonRadius: 22.0,
    outlinedButtonRadius: 23.0,
    outlinedButtonOutlineSchemeColor: SchemeColor.primary,
    outlinedButtonBorderWidth: 2.0,
    outlinedButtonPressedBorderWidth: 2.0,
    toggleButtonsRadius: 17.0,
    inputDecoratorRadius: 33.0,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorFocusedBorderWidth: 2.5,
    fabSchemeColor: SchemeColor.primary,
    chipSelectedSchemeColor: SchemeColor.onPrimary,
    chipDeleteIconSchemeColor: SchemeColor.primary,
    chipRadius: 4.0,
    cardRadius: 22.0,
    popupMenuRadius: 2.0,
    popupMenuElevation: 6.0,
    popupMenuSchemeColor: SchemeColor.onPrimary,
    popupMenuOpacity: 0.99,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
),
darkTheme: FlexThemeData.dark(
  scheme: FlexScheme.verdunHemlock,
  surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
  blendLevel: 22,
  tabBarStyle: FlexTabBarStyle.universal,
  darkIsTrueBlack: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 40,
    useFlutterDefaults: true,
    defaultRadius: 7.0,
    thinBorderWidth: 1.0,
    textButtonRadius: 11.0,
    elevatedButtonRadius: 22.0,
    outlinedButtonRadius: 23.0,
    outlinedButtonOutlineSchemeColor: SchemeColor.primary,
    outlinedButtonBorderWidth: 2.0,
    outlinedButtonPressedBorderWidth: 2.0,
    toggleButtonsRadius: 17.0,
    inputDecoratorRadius: 33.0,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorFocusedBorderWidth: 2.5,
    fabSchemeColor: SchemeColor.primary,
    chipSelectedSchemeColor: SchemeColor.onPrimary,
    chipDeleteIconSchemeColor: SchemeColor.primary,
    chipRadius: 4.0,
    cardRadius: 22.0,
    popupMenuRadius: 2.0,
    popupMenuElevation: 6.0,
    popupMenuSchemeColor: SchemeColor.onPrimary,
    popupMenuOpacity: 0.99,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

      home: FutureBuilder(
        future: _initializeApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
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
