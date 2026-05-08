import 'package:flutter/material.dart';
import 'dart:math';

class BillSummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const BillSummaryScreen({super.key, this.cartItems = const []});

  int get total {
    int sum = 0;
    for (var item in cartItems) {
      sum += (item["qty"] as int) * (item["price"] as int);
    }
    return sum;
  }

  String generateBillNumber() {
    return "#${Random().nextInt(99999).toString().padLeft(5, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // If cartItems is empty, use sample data for demonstration
    final List<Map<String, dynamic>> displayItems = cartItems.isEmpty ? [
      {"name": "Espresso", "qty": 2, "price": 100},
      {"name": "Latte", "qty": 1, "price": 250},
      {"name": "Cappuccino", "qty": 3, "price": 50},
    ] : cartItems;

    final String billNo = generateBillNumber();
    final DateTime now = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFF031B3A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF031B3A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          /// HEADER
          const SizedBox(height: 20),
          const Icon(Icons.check_circle, color: Colors.white, size: 70),
          const SizedBox(height: 10),
          const Text(
            "BILL SUMMARY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          /// WHITE CARD
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: <Widget>[
                  /// BILL INFO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Bill No.\n$billNo",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Date\n${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Time\n${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// TABLE HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Product",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Qty",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Total",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),

                  /// ITEM LIST
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Map<String, dynamic> item = displayItems[index];
                        final int itemQty = item["qty"] as int;
                        final int itemPrice = item["price"] as int;
                        final int itemTotal = itemQty * itemPrice;
                        final String itemName = item["name"] as String;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(itemName, overflow: TextOverflow.ellipsis),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  itemQty.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Rs.${itemPrice.toString()}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Rs.${itemTotal.toString()}",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),

                  /// TOTAL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "TOTAL AMOUNT",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rs.${cartItems.isEmpty ? 500 : total.toString()}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// BUTTONS
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Print functionality not implemented.')),
                            );
                          },
                          icon: const Icon(Icons.print),
                          label: const Text("Print"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Share functionality not implemented.')),
                            );
                          },
                          icon: const Icon(Icons.share),
                          label: const Text("Share"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Done"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
