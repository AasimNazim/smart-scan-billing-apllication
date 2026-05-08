import 'package:flutter/material.dart';

class ScanCartScreen extends StatefulWidget {
  const ScanCartScreen({super.key});

  @override
  State<ScanCartScreen> createState() => _ScanCartScreenState();
}

class _ScanCartScreenState extends State<ScanCartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Lays Classic",
      "qty": 1,
      "price": 50,
    },
    {
      "name": "Milk 1L",
      "qty": 2,
      "price": 200,
    },
    {
      "name": "Bread",
      "qty": 1,
      "price": 30,
    },
  ];

  int get total {
    int sum = 0;

    for (var item in cartItems) {
      sum += (item["qty"] as int) * (item["price"] as int);
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031B3A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF031B3A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Scan Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.flash_on,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// CAMERA SECTION
          Container(
            margin: const EdgeInsets.all(15),
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1586880244406-556ebe35f282",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 260,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 55,
                  ),
                ),
              ],
            ),
          ),

          /// CART SECTION
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Scanned Items",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              cartItems.clear();
                            });
                          },
                          child: const Text(
                            "Clear All",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// PRODUCT LIST
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                /// PRODUCT IMAGE
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.shopping_bag,
                                    color: Colors.blue,
                                  ),
                                ),

                                const SizedBox(width: 15),

                                /// PRODUCT DETAILS
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["name"],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Qty: ${item["qty"]}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// PRICE
                                Text(
                                  "Rs.${item["price"]}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    /// TOTAL SECTION
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TOTAL",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rs.$total",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// BUTTONS
                    Row(
                      children: [
                        /// CLEAR CART
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                cartItems.clear();
                              });
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text(
                              "Clear Cart",
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF031B3A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        /// GENERATE BILL
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/generate-bill');
                            },
                            icon: const Icon(Icons.receipt_long),
                            label: const Text(
                              "Generate Bill",
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF031B3A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
