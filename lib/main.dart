import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
    appId: '1:182743752167:web:9a9c4f5594dcef7912f142', 
    messagingSenderId: '182743752167', 
    apiKey: 'AIzaSyBDphgF6MlWdGfz5aUfZh4aJ6ScWAOqITA', 
    projectId: 'igitendance-dev',
    authDomain: 'digitendance-dev.firebaseapp.com',

    ),
  );
  runApp( ProviderScope(child: MyApp()));
}


