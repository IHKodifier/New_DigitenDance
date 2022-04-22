import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';

enum LoginProviderType { EmailPassword, Google, Facebook, Twitter, Phone }

// final dbProvider = Provider<FirebaseFirestore>((ref) =>
//    FirebaseFirestore.instance);


  final dbApiProvider = Provider<DbApi>((ref) =>DbApi());