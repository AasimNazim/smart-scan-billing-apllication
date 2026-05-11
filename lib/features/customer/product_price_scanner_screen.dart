import 'package:flutter/material.dart';

class ProductPriceScannerScreen extends StatefulWidget {
  const ProductPriceScannerScreen({super.key});

  @override
  State<ProductPriceScannerScreen> createState() => _ProductPriceScannerScreenState();
}

class _ProductPriceScannerScreenState extends State<ProductPriceScannerScreen> {
  bool _isScanning = true;
  Map<String, String>? _foundProduct;

  final List<Map<String, String>> _mockProducts = [
    {"name": "Lays Classic", "price": "50"},
    {"name": "Coca Cola 500ml", "price": "80"},
    {"name": "Oreo Biscuits", "price": "40"},
    {"name": "Dairy Milk", "price": "100"},
  ];
  int _currentIndex = 0;

  void _simulateScan() {
    setState(() {
      _isScanning = true;
      _foundProduct = null;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _foundProduct = _mockProducts[_currentIndex];
          _currentIndex = (_currentIndex + 1) % _mockProducts.length;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _simulateScan();
  }

  @override
  Widget build(BuildContext context) {
    final String shopName = ModalRoute.of(context)!.settings.arguments as String? ?? "Smart Mart";

    return Scaffold(
      backgroundColor: const Color(0xFF0A3D62),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [Color(0xFF4FC3F7), Color(0xFF0A3D62)],
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shopName,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 5),
                          const Text("Connected Shop", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Scanner Area
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://images.unsplash.com/photo-1586880244406-556ebe35f282"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          children: [
                            _buildCorner(top: 0, left: 0),
                            _buildCorner(top: 0, right: 0),
                            _buildCorner(bottom: 0, left: 0),
                            _buildCorner(bottom: 0, right: 0),
                            Center(
                              child: Container(
                                width: 230,
                                height: 2,
                                color: _isScanning ? Colors.red : Colors.greenAccent,
                              ),
                            ),
                            if (_isScanning)
                              const Center(child: CircularProgressIndicator(color: Colors.white70)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_isScanning ? Icons.sync : Icons.check_circle, color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              _isScanning ? "Scanning..." : "Scan Complete",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Product Details Card - Adjusted size and removed scroll
          if (!_isScanning)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Fits the content exactly
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                        child: const Icon(Icons.check, color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Product Found",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A3D62).withOpacity(0.03),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _foundProduct?["name"] ?? "---",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0A3D62)),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Product Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Rs. ${_foundProduct?["price"] ?? "0"}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _simulateScan,
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text(
                        "Scan Another Product",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF0A3D62),
                        side: const BorderSide(color: Color(0xFF0A3D62)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCorner({double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top: top != null ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            bottom: bottom != null ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            left: left != null ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            right: right != null ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
