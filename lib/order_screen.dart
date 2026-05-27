import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const OrderScreen({super.key, required this.product});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // 🔥 ADD THIS INSIDE _OrderScreenState (above build method)

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String paymentMethod = "Cash on Delivery";
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

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

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(15),
            ),

            // 🔥 REPLACE ONLY YOUR child: Column(
            // with this full upgraded column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "ORDER DETAILS",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Center(child: Image.network(product["thumbnail"], height: 150)),

                SizedBox(height: 20),

                Text(
                  "Product: ${product["title"]}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                SizedBox(height: 10),

                Text(
                  "Price: ₹${product["price"]}",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Row(
                  children: [
                    Text("Quantity:", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 15),

                    IconButton(
                      onPressed: () {
                        if (qty > 1) {
                          setState(() {
                            qty--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                    ),

                    Text(
                      "$qty",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          qty++;
                        });
                      },
                      icon: Icon(Icons.add_circle, color: Colors.green),
                    ),
                  ],
                ),

                Divider(color: Colors.white30),

                Text(
                  "Delivery Address",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),

                TextField(
                  controller: phoneController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),

                TextField(
                  controller: addressController,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "Full Address",
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Payment Method",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: paymentMethod,
                  isExpanded: true,
                  style: TextStyle(color: Colors.white),
                  items:
                      [
                        "Cash on Delivery",
                        "UPI",
                        "Debit Card",
                        "Net Banking",
                      ].map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                ),

                Divider(color: Colors.white30),

                Text(
                  "Mail ID: nvmnvm1971@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 8),

                Text(
                  "Created At: ${product["meta"]?["createdAt"] ?? "N/A"}",
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 8),

                Text(
                  "Updated At: ${product["meta"]?["updatedAt"] ?? "N/A"}",
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 8),

                Text(
                  "Barcode: ${product["meta"]?["barcode"] ?? "N/A"}",
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 15),

                Center(
                  child: Image.network(
                    product["meta"]?["qrCode"] ?? "",
                    height: 120,
                    width: 120,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Total Amount: ₹${product["price"] * qty}",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: EdgeInsets.all(15),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white60,
                          title: Text(
                            "Order Confirmed 🎉",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          content: Text(
                            "Your order placed successfully!",
                            style: TextStyle(
                              color: Colors.lightGreen[900],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          actions: [
                            Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context); // close dialog
                                  Navigator.pop(
                                    context,
                                  ); // close order page -> back to previous(Home/Product)
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Place Order",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
