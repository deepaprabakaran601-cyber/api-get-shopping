import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB2a6_Nyc4eRoRE8qLxnrJ-xaqTXoTtBzI",
      appId: "1:1020233441618:android:af7a60f82a6679b0319a8b",
      messagingSenderId: "1020233441618",
      projectId: "quickshoping-9c71f",
    ),
  );
  runApp(MyApp());
}
