import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

enum LoginProviderType { EmailPassword, Google, Facebook, Twitter, Phone }

// final dbProvider = Provider<FirebaseFirestore>((ref) =>
//    FirebaseFirestore.instance);

final dbApiProvider = Provider<DbApi>((ref) => DbApi());

const colorScheme1 = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 100, 7, 121),
    onPrimary: Color.fromARGB(255, 250, 247, 251),
    secondary: Color.fromARGB(250, 219, 44, 238),
    onSecondary: Color.fromARGB(237, 246, 245, 248),

    // ignore: unnecessary_const
    error: const Color(0x00b00020),
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0x00000000),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0x00000000));
// Col