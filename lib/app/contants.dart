import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

enum LoginProviderType { EmailPassword, Google, Facebook, Twitter, Phone }

// final dbProvider = Provider<FirebaseFirestore>((ref) =>
//    FirebaseFirestore.instance);

final dbApiProvider = Provider<DbApi>((ref) => DbApi());

const colorScheme1 = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 82, 123, 25),
    onPrimary: Color.fromARGB(255, 12, 46, 2),
    secondary: Color(0x00000000),
    onSecondary: Color(0x006300ee),
    
    // ignore: unnecessary_const
    error: const Color(0x00b00020),
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0x00000000),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0x00000000));
// Col