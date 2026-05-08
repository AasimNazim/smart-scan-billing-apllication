import 'package:flutter/material.dart';

class BillingHistoryScreen extends StatelessWidget {
  const BillingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample history data
    final List<Map<String, dynamic>> history = [
      {"billNo": "#12345", "date": "2023-10-27", "amount": 450},
      {"billNo": "#12346", "date": "2023-10-26", "amount": 1200},
      {"billNo": "#12347", "date": "2023-10-25", "amount": 300},
    ];

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
          "Billing History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 2,
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF031B3A),
                          child: Icon(Icons.receipt, color: Colors.white),
                        ),
                        title: Text("Bill ${item['billNo']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("Date: ${item['date']}"),
                        trailing: Text(
                          "Rs.${item['amount']}",
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
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
    );
  }
}
