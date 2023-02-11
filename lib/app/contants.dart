import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

enum LoginProviderType { EmailPassword, Google, Facebook, Twitter, Phone }

// final dbProvider = Provider<FirebaseFirestore>((ref) =>
//    FirebaseFirestore.instance);

final dbApiProvider = Provider<DbApi>((ref) => DbApi());

