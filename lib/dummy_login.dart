import 'package:flutter/material.dart';
import 'package:shoping_app/home_screen.dart';

class DummyLogin extends StatefulWidget {
  const DummyLogin({super.key});

  @override
  State<DummyLogin> createState() => _DummyLoginState();
}

class _DummyLoginState extends State<DummyLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireBase Login Page"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          color: Colors.black45,
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
    );
  }
}
