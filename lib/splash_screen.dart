import 'package:flutter/material.dart';
import 'package:shoping_app/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoping_app/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigatToHome(); // ✅ important
  }

  Future<void> navigatToHome() async {
    await Future.delayed(Duration(seconds: 3));

    final user = FirebaseAuth.instance.currentUser;

    // 🧠 IMPORTANT: reload user to get latest state
    await user?.reload();

    final updatedUser = FirebaseAuth.instance.currentUser;

    if (updatedUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/image/addcart3.gif"),
                width: 120,
                height: 120,
              ),
              Text(
                "Shopping App",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
