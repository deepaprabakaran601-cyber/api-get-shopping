import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shoping_app/home_screen.dart';
import 'package:shoping_app/sigup_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
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

                const SizedBox(height: 12),

                /// 🔹 Get Started Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await auth
                            .signInWithEmailAndPassword(
                              email: mail.text,
                              password: password.text,
                            );
                        final user = userCredential.user;
                        if (user == null) {
                          return;
                        }

                        if (!user.emailVerified) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please verify your email first!"),
                            ),
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("LogIn Successfully! ${user.email}"),
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } on FirebaseAuthException catch (e) {
                        String msg = "";

                        if (e.code == "invalid-email") {
                          msg = "Please enter a valid email address.";
                        } else if (e.code == "user-disabled") {
                          msg =
                              "This account has been disabled. Please contact support.";
                        } else if (e.code == "user-not-found") {
                          msg = "No account found with this email.";
                        } else if (e.code == "wrong-password") {
                          msg = "Incorrect password. Please try again.";
                        } else if (e.code == "invalid-credential") {
                          msg = "Invalid email or password.";
                        } else if (e.code == "too-many-requests") {
                          msg =
                              "Too many login attempts. Please try again later.";
                        } else if (e.code == "network-request-failed") {
                          msg =
                              "Network error. Please check your internet connection.";
                        } else if (e.code == "operation-not-allowed") {
                          msg = "Email/password login is not enabled.";
                        } else if (e.code == "internal-error") {
                          msg = "Something went wrong. Please try again.";
                        } else {
                          msg = "Login failed. ${e.message}";
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
                      "Get Start",
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

                /// 🔹 Social Buttons
                Row(
                  children: [
                    /// Google
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/image/google.png",
                          height: 20,
                        ),
                        label: const Text("Google"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// Facebook
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook),
                        label: const Text("Facebook"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3b5998),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                /// 🔹 Subtitle
                const Text(
                  "If you are a new user first registor you account to this application ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigupScreen()),
                    );
                  },
                  child: Text("Sign-in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> versionCheck() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    final double appcurrentVersion = double.parse(
      info.version.trim().replaceAll(".", ""),
    );
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: Duration(seconds: 15),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();

      final double minVersion = double.parse(
        remoteConfig
            .getString("Force Update min_version")
            .trim()
            .replaceAll(".", ""),
      );

      final double maxVersion = double.parse(
        remoteConfig
            .getString("Force Update max_version")
            .trim()
            .replaceAll(".", ""),
      );

      final String updateUrl = remoteConfig.getString(
        "Force Update update_url",
      );
      if (kDebugMode) {
        print("appcurrentVersion: $appcurrentVersion");
        print("minVersion: $minVersion");
        print("maxVersion: $maxVersion");
      }

      if (maxVersion > appcurrentVersion) {
        final bool isForceUpdate = appcurrentVersion < minVersion;
        showUpadateDialog(context, updateUrl, isForceUpdate);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch remote config: $e")),
      );
    }
  }

  void showUpadateDialog(BuildContext context, String url, bool isForceUpdate) {
    showDialog(
      context: context,
      barrierDismissible: isForceUpdate ? true : false,
      builder: (context) {
        return AlertDialog(
          title: Text(isForceUpdate ? "Update Required" : "Update Available"),
          content: Text(
            isForceUpdate
                ? 'You must Update the app to continue to use it.'
                : "A new version of the app is available. Please update to enjoy the latest features and improvements.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                _luncherUrl(url);
                Navigator.pop(context);
              },
              child: Text("Update Now"),
            ),
            if (!isForceUpdate)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Later"),
              ),
          ],
        );
      },
    );
  }

  Future<void> _luncherUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception("Could not launch $url");
    }
  }
}
