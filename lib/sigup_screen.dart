import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoping_app/home_screen.dart';
import 'package:shoping_app/login_screen.dart';

class SigupScreen extends StatefulWidget {
  const SigupScreen({super.key});

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController date = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2A35),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2A35),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔹 Top Image + Close Button
                Stack(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/image/gif.gif", // 🔥 add your image
                          height: 180,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// 🔹 Title
                const Text(
                  "We made a Quick Shopping app for you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const SizedBox(height: 20),

                /// 🔹 Name Field
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your full name...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                /// 🔹 Email Field
                TextField(
                  controller: mail,
                  decoration: InputDecoration(
                    hintText: "Enter your email...",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your Password...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: date,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Date and Time",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// 🔹 Get Started Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await auth
                            .createUserWithEmailAndPassword(
                              email: mail.text,
                              password: password.text,
                            );
                        final user = userCredential.user;
                        if (user == null) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Rejuster successfully!${user.email}",
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              top: 20,
                              left: 10,
                              right: 10,
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        await user.sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Verification email sent. Please verify.",
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              top: 20,
                              left: 10,
                              right: 10,
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } on FirebaseAuthException catch (e) {
                        String msg = "";

                        if (e.code == "email-already-in-usea") {
                          msg =
                              "This email is already registered. Please use a different email.";
                        } else if (e.code == "invalid-email") {
                          msg = "Please enter a valid email address.";
                        } else if (e.code == "operation-not-allowed") {
                          msg =
                              "Email/Password sign-in is not enabled. Please contact support.";
                        } else if (e.code == "weak-password") {
                          msg = "Password must be at least 6 characters long.";
                        } else if (e.code == "too-many-requests") {
                          msg = "Too many attempts. Please try again later.";
                        } else if (e.code == "user-disabled") {
                          msg = "This user account has been disabled.";
                        } else if (e.code == "user-not-found") {
                          msg = "No user found with this email.";
                        } else if (e.code == "wrong-password") {
                          msg = "Incorrect password. Please try again.";
                        } else if (e.code == "network-request-failed") {
                          msg =
                              "Network error. Please check your internet connection.";
                        } else if (e.code == "requires-recent-login") {
                          msg = "Please login again and retry.";
                        } else if (e.code == "credential-already-in-use") {
                          msg =
                              "This credential is already linked with another account.";
                        } else if (e.code ==
                            "account-exists-with-different-credential") {
                          msg =
                              "An account already exists with a different sign-in method.";
                        } else if (e.code == "invalid-credential") {
                          msg = "Invalid login credentials.";
                        } else if (e.code == "invalid-verification-code") {
                          msg = "Invalid verification code.";
                        } else if (e.code == "invalid-verification-id") {
                          msg = "Invalid verification ID.";
                        } else if (e.code == "session-expired") {
                          msg = "Session expired. Please request a new code.";
                        } else {
                          msg = "Authentication failed: ${e.message}";
                        }

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(msg)));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(height: 20),

                /// 🔹 Subtitle
                const Text(
                  "If you already have an Account get back to ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Log-in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSingInAccount = await GoogleSignIn()
          .signIn();

      if (googleSingInAccount == null) return;
      final googleAuth = await googleSingInAccount.authentication;
      final googleCredentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      UserCredential userCredential = await auth.signInWithCredential(
        googleCredentials,
      );
      final user = userCredential.user;
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
