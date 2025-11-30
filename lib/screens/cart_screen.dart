import 'package:flutter/material.dart';
import 'payment_success_screen.dart'; // pastikan file ini sudah ada

class CartScreen_taruna extends StatefulWidget { 
  const CartScreen_taruna({super.key});

  @override
  State<CartScreen_taruna> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen_taruna> {
  final List<Map<String, dynamic>> cartItems_taruna = [
    {
      'name': 'Nasi Goreng',
      'price': 15000,
      'quantity': 1,
      'image': 'assets/images/nasi_goreng.jpg',
    },
    {
      'name': 'Sate Kambing',
      'price': 35000,
      'quantity': 2,
      'image': 'assets/images/sate_kambing.jpg',
    },
    {
      'name': 'Soto Ayam',
      'price': 20000,
      'quantity': 3,
      'image': 'assets/images/soto_ayam.jpg',
    },
    {
      'name': 'Rujak Lontong',
      'price': 12000,
      'quantity': 4,
      'image': 'assets/images/rujak_lontong.jpg',
    },
  ];

  String pickupTime_taruna = 'Sekarang';
  final List<String> pickupOptions_taruna = ['Sekarang', '12:00', '12:30', '13:00'];

  double get totalPrice_taruna => cartItems_taruna.fold(
    0,
    (sum, item) => sum + (item['price'] * item['quantity']),
  );

  void _incrementQuantity_taruna(int index) {
    setState(() => cartItems_taruna[index]['quantity']++);
  }

  void _decrementQuantity_taruna(int index) {
    setState(() {
      if (cartItems_taruna[index]['quantity'] > 1) cartItems_taruna[index]['quantity']--;
    });
  }

  void _removeItem_taruna(int index) {
    setState(() => cartItems_taruna.removeAt(index));
  }

  void _selectPickupTime_taruna(String time) {
    setState(() => pickupTime_taruna = time);
  }

  void _proceedToCheckout_taruna() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen_Rapli(
          cartItems_Rapli: cartItems_taruna,
          totalPrice_Rapli: totalPrice_taruna,
          pickupTime_Rapli: pickupTime_taruna,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.access_time, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Pilih Waktu Ambil'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: pickupOptions_taruna
                        .map(
                          (option) => ListTile(
                            title: Text(option),
                            onTap: () {
                              _selectPickupTime_taruna(option);
                              Navigator.pop(context);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366),
              Color(0xFF000033),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: cartItems_taruna.isEmpty
            ? const Center(
                child: Text(
                  'Keranjang kosong',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: kToolbarHeight + 20,
                        left: 16,
                        right: 16,
                      ),
                      itemCount: cartItems_taruna.length,
                      itemBuilder: (context, index) {
                        final item = cartItems_taruna[index];
                        return Card(
                          color: Colors.white.withOpacity(0.1),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(item['image']),
                              radius: 30,
                              onBackgroundImageError: (exception, stackTrace) {
                                print('Error loading image: $exception');
                              },
                              child: const Icon(
                                Icons.fastfood,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              item['name'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Rp ${item['price']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, color: Colors.white),
                                  onPressed: () => _decrementQuantity_taruna(index),
                                ),
                                Text(
                                  '${item['quantity']}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, color: Colors.white),
                                  onPressed: () => _incrementQuantity_taruna(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeItem_taruna(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: Rp ${totalPrice_taruna.toInt()}',
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        ElevatedButton(
                          onPressed: _proceedToCheckout_taruna,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF003366),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
