import 'package:flutter/material.dart';
import 'package:shoping_app/cart_screen.dart';
import 'package:shoping_app/order_screen.dart';

class ProductScreen extends StatefulWidget {
  final Map<String, dynamic> product; // ✅ ADD THIS
  final List<dynamic> allProducts;

  const ProductScreen({
    super.key,
    required this.product,
    required this.allProducts,
  }); // ✅ UPDATE

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Map<String, dynamic> product;
  bool showDetails = false;
  TextEditingController commentController = TextEditingController();
  int myRating = 5;
  @override
  void initState() {
    super.initState();
    product = widget.product; // ✅ get passed product
  }

  @override
  Widget build(BuildContext context) {
    final reviews = product["reviews"] ?? [];

    // total reviews
    int totalReviews = reviews.length;

    // total comments (only non-empty)
    int totalComments = reviews
        .where(
          (r) => r["comment"] != null && r["comment"].toString().isNotEmpty,
        )
        .length;

    return Scaffold(
      backgroundColor: Color(0xFF121212),
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

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),

              child: Text("PRODUCTS DETAILS"),
            ),
          ],
        ),
      ),

      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${product["title"]}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.10,
                          ),
                        ),
                      ),
                      // 🔹 Image
                      Image.network(
                        (product["images"] != null &&
                                product["images"].isNotEmpty)
                            ? product["images"][0]
                            : "https://via.placeholder.com/150",
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: 20),

                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    myCart.add(product);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartScreen(),
                                      ),
                                    );
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${product["title"]} added to cart",
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                label: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.pink[300],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 50), // ✅ reduced width
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ), // ✅ FIXED
                                  ),
                                  side: BorderSide(
                                    color: Colors.purple,
                                    width: 3,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.shopping_cart_sharp,
                                  color: Colors.pink[300],
                                ),
                              ),

                              SizedBox(width: 20),

                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderScreen(product: product),
                                    ),
                                  );
                                },
                                label: Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 50), // ✅ reduced width
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ), // ✅ FIXED
                                  ),
                                  side: BorderSide(
                                    color: Colors.purple,
                                    width: 3,
                                  ),
                                  backgroundColor: Colors.pink[300],
                                ),
                                icon: Icon(
                                  Icons.keyboard_double_arrow_right_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 10),
                      // 🔹 Title
                      Container(
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Similar Pictures",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.10,
                                  ),
                                ),
                              ),

                              SizedBox(height: 15),

                              Center(
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.purple,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.network(
                                    product["thumbnail"],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),

                      // 🔹 Description
                      Container(
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Product Description",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.10,
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              Text(
                                product["description"] ?? "No Description",
                                style: TextStyle(color: Colors.white70),
                              ),

                              SizedBox(height: 10),

                              Row(
                                children: [
                                  Text(
                                    "₹${(product["price"] - (product["price"] * product["discountPercentage"] / 100)).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(width: 25),

                                  Text(
                                    "₹${product["price"]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 17,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey,
                                      decorationThickness: 4,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10),

                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${product["discountPercentage"]}% OFF",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                              SizedBox(height: 15),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.green[700],
                                    ),
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 17,
                                      ),
                                      label: Text(
                                        "${product["rating"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 40),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Reviews: $totalReviews",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Text(
                                        "Total Comments: $totalComments",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              Align(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.reviews,
                                    color: Colors.orange,
                                  ),
                                  label: Text(
                                    "User Reviews",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: reviews.length,
                                itemBuilder: (context, index) {
                                  final review = reviews[index];

                                  return Card(
                                    color: Colors.black54,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review["reviewerName"] ?? "User",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(height: 5),

                                          Row(
                                            children: List.generate(
                                              5,
                                              (starIndex) => Icon(
                                                Icons.star,
                                                size: 18,
                                                color:
                                                    starIndex <
                                                        (review["rating"] ?? 0)
                                                    ? Colors.amber
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 8),

                                          Text(
                                            review["comment"] ?? "No Comment",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: commentController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Write comment...",
                                      hintStyle: TextStyle(
                                        color: Colors.white54,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => IconButton(
                                        onPressed: () {
                                          setState(() {
                                            myRating = index + 1;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.star,
                                          color: index < myRating
                                              ? Colors.amber
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      if (commentController.text
                                          .trim()
                                          .isNotEmpty) {
                                        setState(() {
                                          reviews.add({
                                            "reviewerName": "You",
                                            "rating": myRating,
                                            "comment": commentController.text,
                                          });
                                        });

                                        commentController.clear();
                                        myRating = 5;
                                      }
                                    },
                                    child: Text(
                                      "Add Yours",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Container(
                        color: Colors.grey[900],
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Mall",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // 🔹 Original Brand
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Original Brand",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),

                                // 🔹 Authorised Seller
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Authorised seller",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),

                                // 🔹 Arrow
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Divider(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Product Highlights",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.10,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Tags",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${product["tags"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Brand",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${product["brand"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "SKU-Details",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${product["sku"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Cepacity",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${product["weight"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Dimensions",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${product["dimensions"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Minimum Order Quantity",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${product["minimumOrderQuantity"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                child: Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          showDetails =
                                              !showDetails; // 🔥 toggle
                                        });
                                      },
                                      label: Text(
                                        "Additional Details",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      icon: Icon(
                                        showDetails
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        size: 35,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              showDetails
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.all(10),

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Brand: ${product["brand"] ?? "No Brand"}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              "Category: ${product["category"] ?? "No Category"}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              "Stock: ${product["stock"] ?? "0"}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              "Warranty: ${product["warrantyInformation"] ?? "No Warranty"}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Divider(),
                                            SizedBox(height: 10),
                                            Text(
                                              "Shipping Information: ${product["shippingInformation"] ?? "No Shipping Information"}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Availability Status: ${product["availabilityStatus"] ?? "No Stock Available"}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,

                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Return Policy: ${product["returnPolicy"] ?? "data not found"}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(height: 15),
                              Divider(),
                              SizedBox(height: 10),

                              // 🔥 JUST ADD THIS BELOW:
                              // Divider(),
                              // SizedBox(height: 10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Special Offers",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),

                              SizedBox(height: 15),

                              SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4, // only 2 products
                                  itemBuilder: (context, index) {
                                    List sameCategory = widget.allProducts
                                        .where(
                                          (item) =>
                                              item["category"] ==
                                                  product["category"] &&
                                              item["id"] != product["id"],
                                        )
                                        .take(4)
                                        .toList();

                                    if (sameCategory.isEmpty ||
                                        index >= sameCategory.length) {
                                      return SizedBox();
                                    }

                                    final item = sameCategory[index];

                                    double offerPrice =
                                        item["price"] -
                                        (item["price"] *
                                            item["discountPercentage"] /
                                            100);

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ProductScreen(
                                              product: item,
                                              allProducts: widget.allProducts,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 170,
                                        margin: EdgeInsets.only(right: 12),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.purple,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Image.network(
                                                  item["thumbnail"],
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 8),

                                            Text(
                                              item["title"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(height: 8),

                                            Text(
                                              "₹${offerPrice.toStringAsFixed(0)}",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),

                                            Text(
                                              "₹${item["price"]}",
                                              style: TextStyle(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.pink,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                "${item["discountPercentage"].toStringAsFixed(0)}% OFF",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
