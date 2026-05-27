import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoping_app/cart_screen.dart';
import 'package:shoping_app/login_screen.dart';
import 'package:shoping_app/product_screen.dart';
import 'package:shoping_app/user_account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  List<dynamic> categoryProducts = [];
  int currentIndex = 0; // 🔥 add this in your State

  TextEditingController search = TextEditingController();
  List<dynamic> productList = [];
  bool showReviews = false;
  List<dynamic> filteredProduct = [];

  Map<String, dynamic>? selectedProduct;

  Future<List<dynamic>> getProductData() async {
    try {
      var url = "https://dummyjson.com/products";

      var responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        final body = jsonDecode(responce.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Data Fetched Successfully!")));

        return body["products"];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong!\nCan't fetched the data "),
          ),
        );
        return [];
      }
    } catch (e) {
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 10),
            Text("Error occurred"),
          ],
        ),
      );
      return [];
    }
  }

  List<Map<String, String>> getCategoriesFromProducts(List products) {
    Map<String, List<dynamic>> categoryMap = {};

    for (var item in products) {
      String name = (item["tags"] != null && item["tags"].isNotEmpty)
          ? item["tags"][0]
          : item["category"];

      if (!categoryMap.containsKey(name)) {
        categoryMap[name] = [];
      }

      categoryMap[name]!.add(item);
    }

    List<Map<String, String>> categoryList = [];

    // ✅ ADD "ALL" FIRST
    categoryList.add({
      "name": "All",
      "image":
          "https://cdn-icons-png.flaticon.com/512/1828/1828919.png", // any icon
    });

    // ✅ Then add API categories
    for (var entry in categoryMap.entries.take(4)) {
      var items = entry.value;

      categoryList.add({"name": entry.key, "image": items[0]["images"][0]});
    }

    return categoryList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF262833),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F172A),
        toolbarHeight: 80,
        leading: Icon(
          Icons.shopping_cart_checkout_outlined,
          color: Colors.white,
          size: 40,
        ),
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

      body: FutureBuilder(
        future: getProductData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Somthing went wrong!"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Products are Founded here?"));
          }

          final product = snapshot.data!;
          final categories = getCategoriesFromProducts(product);
          if (categoryProducts.isEmpty) {
            selectedCategory = "All";
            categoryProducts = product; // ✅ show all by default
          }

          if (categoryProducts.isNotEmpty) {
            filteredProduct = product;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsetsGeometry.all(7)),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // background of input
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4), // glow color
                          blurRadius: 12, // spread of glow
                          spreadRadius: 1,
                          offset: const Offset(0, 0), // centered glow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Search Products...",
                        hintStyle: const TextStyle(color: Colors.black54),

                        prefixIcon: const Icon(
                          Icons.search,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        suffixIcon: const Icon(
                          Icons.mic_none,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none, // remove default border
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  SizedBox(
                    height: 110,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, // 🔥 one row like your image
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.8,
                          ),
                      itemBuilder: (context, index) {
                        final item = categories[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = item["name"];

                              if (item["name"] == "All") {
                                categoryProducts = product; // ✅ show all
                              } else {
                                categoryProducts = product.where((p) {
                                  return p["tags"] != null &&
                                      p["tags"].contains(item["name"]);
                                }).toList();
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedCategory == item["name"]
                                        ? Color(0xFFFFA500)
                                        : Colors
                                              .grey, // 🔥 change color when selected
                                    width: 3,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      selectedCategory == item["name"]
                                      ? Colors.deepPurple.withOpacity(
                                          0.5,
                                        ) // 🔥 background highlight
                                      : Colors.white,
                                  backgroundImage: NetworkImage(item["image"]!),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item["name"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (categoryProducts.isNotEmpty) ...[
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Category Products",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          final item = categoryProducts[index]; // ✅ FIXED

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    product: item,
                                    allProducts: product,
                                  ),
                                  //  ProductScreen(product:product {}),
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.symmetric(horizontal: 6),
                              child: Card(
                                color: Color(0xFF0B1A3A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    // 🔹 IMAGE (takes more space now)
                                    Expanded(
                                      flex: 6,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                        child: Image.network(
                                          item["images"][0],
                                          width: double.infinity,
                                          fit: BoxFit
                                              .contain, // ✅ better than contain
                                        ),
                                      ),
                                    ),
                                    Divider(color: Colors.grey, height: 0.85),

                                    // 🔹 TEXT AREA
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item["title"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              " ₹${(item["price"] - (item["price"] * item["discountPercentage"] / 100)).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${item["price"]}",
                                                  style: TextStyle(
                                                    color: Colors.yellowAccent,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        Colors.white,
                                                    decorationThickness: 3,
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                Text(
                                                  "₹${item["discountPercentage"]}%",
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.blue,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  size: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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

                    if (selectedCategory == "All") ...[
                      const SizedBox(height: 20),

                      Divider(color: Colors.white24, thickness: 1.5),

                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All Products",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${product.length} items",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: product.length, // 🔥 show ALL products
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 🔥 2 cards per row
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                        itemBuilder: (context, index) {
                          final item = product[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    product: item,
                                    allProducts: product,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Card(
                                color: Color(0xFF111827),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                        child: Image.network(
                                          item["images"][0],
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Divider(color: Colors.grey, height: 0.5),

                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item["title"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                Text(
                                                  "₹${item["price"]}",
                                                  style: TextStyle(
                                                    color: Colors.yellowAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  "₹${item["price"] + 200}",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.blue,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  size: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ],

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0F172A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black54, blurRadius: 10, spreadRadius: 1),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: Color(0xFF0F172A),
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,

            onTap: (value) {
              setState(() {
                currentIndex = value;
              });

              switch (value) {
                case 0:
                  // Home
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
                    MaterialPageRoute(
                      builder: (context) => UserAccountScreen(),
                    ),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app),
                label: "LogOut",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
