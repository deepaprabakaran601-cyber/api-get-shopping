import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/cart_screen.dart';
import 'package:shoping_app/home_screen.dart';
import 'package:shoping_app/login_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isDarkMode = false;

  Future<void> showAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    PackageInfo _packageInfo = PackageInfo(
      appName: 'QUICK SHOPING',
      packageName: 'Flutter00',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
      installerStore: 'Unknown',
    );

    void showinfoDialog() {
      showAboutDialog(
        barrierDismissible: false,
        context: context,
        applicationName: _packageInfo.appName,
        applicationVersion: _packageInfo.version,
        applicationIcon: Icon(Icons.flutter_dash),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          title: Text(
            "App Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "App Name: ${packageInfo.appName}",
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 10),

              Text(
                "Package Name: ${packageInfo.packageName}",
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 10),

              Text(
                "Version: ${packageInfo.version}",
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 10),

              Text(
                "Build Number: ${packageInfo.buildNumber}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(width: double.infinity),
            TextButton(
              onPressed: () {
                showinfoDialog();
              },

              child: Text(
                "see more",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF061025) : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF0F172A),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.displayName ?? "MY PROFILE",
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.pinkAccent[100],
              child: Text(
                user?.email != null ? user!.email![0].toUpperCase() : "User",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 18, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x976375A3),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: Card(
                          color: isDarkMode ? Color(0xFF061025) : Colors.white,
                          child: ListTile(
                            title: Text(
                              user?.email?.split("@")[0].toUpperCase() ??
                                  "User",
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 1.50,
                              ),
                            ),

                            subtitle: Text(
                              user?.email ?? "No Email",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),

                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.pinkAccent[100],
                              child: Text(
                                user?.email != null
                                    ? user!.email![0].toUpperCase()
                                    : "User",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "App Settings",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Container(
                        child: Card(
                          color: isDarkMode ? Color(0xFF061025) : Colors.white,

                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.sunny,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                                title: Text(
                                  "Light Mode",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    isDarkMode = !isDarkMode;
                                  });
                                },

                                trailing: Icon(Icons.lightbulb_outline_sharp),
                              ),
                              Divider(),

                              ListTile(
                                leading: Icon(
                                  Icons.apps,
                                  color: Colors.purple,
                                  size: 30,
                                ),
                                title: Text(
                                  "Show App Vesion",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  showAppInfo();
                                },

                                trailing: Icon(Icons.app_settings_alt),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "About Us",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.50,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Container(
                        child: Card(
                          color: isDarkMode ? Color(0xFF061025) : Colors.white,

                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                                title: Text(
                                  "Rate Us",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),

                                onTap: () {
                                  int selectedRating = 0;

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setDialogState) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),

                                            title: Text(
                                              "Rate Our App",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,

                                              children: [
                                                Text(
                                                  "How was your experience?",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),

                                                SizedBox(height: 20),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,

                                                  children: List.generate(
                                                    5,
                                                    (index) => IconButton(
                                                      onPressed: () {
                                                        setDialogState(() {
                                                          selectedRating =
                                                              index + 1;
                                                        });
                                                      },

                                                      icon: Icon(
                                                        Icons.star,

                                                        color:
                                                            index <
                                                                selectedRating
                                                            ? Colors.amber
                                                            : Colors.grey,

                                                        size: 35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },

                                                child: Text("Cancel"),
                                              ),

                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "Thanks for rating $selectedRating ⭐",
                                                      ),
                                                    ),
                                                  );
                                                },

                                                child: Text("Submit"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              Divider(),

                              ListTile(
                                leading: Icon(
                                  Icons.send_rounded,
                                  size: 26,
                                  color: Colors.green,
                                ),
                                onTap: () async {
                                  await Share.share(
                                    "🛍️ Check out my Quick Shop App!\n\nFast shopping experience with amazing offers 🔥",
                                    subject: "Quick Shop App",
                                  );
                                },
                                title: Text(
                                  "Share",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                              ),

                              Divider(),

                              ListTile(
                                leading: Icon(
                                  Icons.message,
                                  size: 26,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  TextEditingController feedbackController =
                                      TextEditingController();

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: isDarkMode
                                            ? Colors.grey[900]
                                            : Colors.white,

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),

                                        title: Text(
                                          "Feedback",
                                          style: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,

                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,

                                          children: [
                                            TextField(
                                              controller: feedbackController,

                                              maxLines: 4,

                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),

                                              decoration: InputDecoration(
                                                hintText:
                                                    "Write your feedback...",

                                                hintStyle: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.white54
                                                      : Colors.black54,
                                                ),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),

                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2,
                                                      ),
                                                    ),

                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),

                                                      borderSide: BorderSide(
                                                        color: Colors.purple,
                                                        width: 3,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },

                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),

                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);

                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Thanks for your feedback ❤️",
                                                  ),
                                                ),
                                              );
                                            },

                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),

                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                title: Text(
                                  "Feedback",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Social MEDIA",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 1.50,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.black : Colors.white,

                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage(
                                      "assets/image/YOUTUBE.jpg",
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    " YOUTUBE",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),

                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 4,
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage(
                                      "assets/image/instagram.jpg",
                                    ),
                                    width: 65,
                                    height: 65,
                                  ),
                                  Text(
                                    "INSTAGRAM",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),

                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isDarkMode ? Colors.black : Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage(
                                      "assets/image/facebook.png",
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "FACEBOOK",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "By signing below, you agree to the ",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Terms and Conditions"),
                          ),
                          Text(
                            " & ",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Privacy Policy\n"),
                          ),
                          Text(
                            "Version:1.0.24",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // ✅ Profile page index
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF0F172A),

        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
              break;

            case 2:
              break;

            case 3:
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Warning",
                      style: TextStyle(color: Colors.red[800]),
                    ),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancle"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          await FirebaseAuth.instance.signOut();

                          if (!mounted) return;

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text("LogOut"),
                      ),
                    ],
                  );
                },
              );

              break;
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: "Logout",
          ),
        ],
      ),
    );
  }
}
