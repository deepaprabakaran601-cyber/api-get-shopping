import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/home_screen.dart';
import 'package:shoping_app/login_screen.dart';
import 'package:shoping_app/user_account_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

List<dynamic> myCart = [];

class _CartScreenState extends State<CartScreen> {
  TextEditingController search = TextEditingController();

  List<Color> colors = [
    Color(0xFF0D0D0D),
    Color(0xFF121212),
    Color(0xFF1A1A1A),
    Color(0xFF1E1E1E),
    Color(0xFF222222),
    Color(0xFF262626),
    Color(0xFF2B2B2B),
    Color(0xFF303030),
    Color(0xFF363636),
    Color(0xFF3D3D3D),
    Color(0xFF444444),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0D0D),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quick Shop",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.10,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Make Your Shopping Easy By Quick Shop",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: CircleAvatar(
                minRadius: 12,
                backgroundColor: Colors.pinkAccent[100],
                child: Text(
                  "DK",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white70, fontSize: 17),
                    cursorColor: Colors.white70,

                    controller: search,
                    decoration: InputDecoration(
                      hint: Text(
                        "search a items here...",
                        style: TextStyle(color: Colors.white),
                      ),
                      label: Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),

                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                      suffixIcon: Icon(
                        Icons.camera_alt_outlined,
                        size: 25,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold,
                    size: 20,
                  ),
                  label: Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400], // 🔥 button color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            SizedBox(height: 20),

            Expanded(
              child: myCart.isEmpty
                  ? Center(
                      child: Text(
                        "Cart is Empty...",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: myCart.length,
                      itemBuilder: (context, index) {
                        final item = myCart[index];

                        return Container(
                          margin: EdgeInsets.only(bottom: 12),

                          child: Card(
                            color: colors[index % colors.length],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),

                            child: Padding(
                              padding: EdgeInsets.all(8),

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  // IMAGE
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        item["images"][0],
                                        height: 160,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  // DETAILS
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          item["title"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "₹ ${item["price"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 5),

                                            Text(
                                              "${item["discountPercentage"]}% off",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 4),

                                        Text(
                                          "₹${(item["price"] - (item["price"] * item["discountPercentage"] / 100)).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),

                                        SizedBox(height: 15),

                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              item["liked"] =
                                                  !(item["liked"] ?? false);
                                            });
                                          },
                                          icon: Icon(
                                            (item["liked"] ?? false)
                                                ? Icons.favorite
                                                : Icons.favorite_border,

                                            color: (item["liked"] ?? false)
                                                ? Colors.red
                                                : Colors.pink,

                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(height: 15),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 38,
                                                child: ElevatedButton(
                                                  onPressed: () {},

                                                  style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.zero,

                                                    backgroundColor:
                                                        Colors.black,

                                                    elevation: 5,

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),

                                                    side: BorderSide(
                                                      color: Colors.greenAccent,
                                                      width: 2.5,
                                                    ),
                                                  ),

                                                  child: FittedBox(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          color: Colors
                                                              .greenAccent,
                                                          size: 18,
                                                        ),

                                                        SizedBox(width: 5),

                                                        Text(
                                                          "BUY",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .greenAccent,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 10),

                                            Expanded(
                                              child: SizedBox(
                                                height: 38,
                                                child: ElevatedButton(
                                                  onPressed: () {},

                                                  style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.zero,

                                                    backgroundColor:
                                                        Colors.black,

                                                    elevation: 5,

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),

                                                    side: BorderSide(
                                                      color: Colors.redAccent,
                                                      width: 3,
                                                    ),
                                                  ),

                                                  child: FittedBox(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.delete,
                                                          color:
                                                              Colors.redAccent,
                                                          size: 18,
                                                        ),

                                                        SizedBox(width: 5),

                                                        Text(
                                                          "Remove",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // ✅ Profile page index
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UserAccountScreen()),
              );
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
            label: "LogOut",
          ),
        ],
      ),
    );
  }
}
