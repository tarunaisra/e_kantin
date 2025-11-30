import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Tambahkan field 'image' ke setiap item
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Nasi Goreng',
      'price': 15000,
      'quantity': 1,
      'image': 'assets/images/nasi_goreng.jpg',
    },
    {
      'name': 'Sate Kambing',
      'price': 20000,
      'quantity': 2,
      'image': 'assets/images/sate_kambing.jpg',
    },
    {
      'name': 'Soto Ayam',
      'price': 13500,
      'quantity': 3,
      'image': 'assets/images/soto_ayam.jpg',
    },
    {
      'name': 'Rujak Lontong',
      'price': 10000,
      'quantity': 4,
      'image': 'assets/images/rujak_lontong.jpg',
    },
  ];

  String pickupTime = 'Sekarang';
  final List<String> pickupOptions = ['Sekarang', '12:00', '12:30', '13:00'];

  double get totalPrice => cartItems.fold(
    0,
    (sum, item) => sum + (item['price'] * item['quantity']),
  );

  void _incrementQuantity(int index) {
    setState(() => cartItems[index]['quantity']++);
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) cartItems[index]['quantity']--;
    });
  }

  void _removeItem(int index) {
    setState(() => cartItems.removeAt(index));
  }

  void _selectPickupTime(String time) {
    setState(() => pickupTime = time);
  }

  void _proceedToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartItems: cartItems,
          totalPrice: totalPrice,
          pickupTime: pickupTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Saya'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.access_time, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Pilih Waktu Ambil'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: pickupOptions
                        .map(
                          (option) => ListTile(
                            title: Text(option),
                            onTap: () {
                              _selectPickupTime(option);
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: cartItems.isEmpty
            ? Center(
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
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Card(
                          color: Colors.white.withValues(alpha: 0.1),
                          child: ListTile(
                            // Tambahkan leading untuk gambar
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(item['image']),
                              radius: 30, // Ukuran gambar
                              onBackgroundImageError: (exception, stackTrace) {
                                // Placeholder jika gambar gagal dimuat
                                print('Error loading image: $exception');
                              },
                              child: Icon(
                                Icons.fastfood,
                                color: Colors.white,
                              ), // Placeholder ikon
                            ),
                            title: Text(
                              item['name'],
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Rp ${item['price']}',
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () => _decrementQuantity(index),
                                ),
                                Text(
                                  '${item['quantity']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPressed: () => _incrementQuantity(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeItem(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: Rp ${totalPrice.toInt()}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        ElevatedButton(
                          onPressed: _proceedToCheckout,
                          child: Text('Checkout'),
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

// CheckoutScreen tetap sama, tidak diubah
class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalPrice;
  final String pickupTime;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.pickupTime,
  });

  void _confirmOrder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pesanan dikonfirmasi! Bayar cash saat pickup pada $pickupTime.',
        ),
      ),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konfirmasi Pesanan')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Pickup: $pickupTime'),
            SizedBox(height: 20),
            Text('Metode: Cash'),
            Spacer(),
            Text(
              'Total: Rp ${totalPrice.toInt()}',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () => _confirmOrder(context),
              child: Text('Konfirmasi'),
            ),
          ],
        ),
      ),
    );
  }
}
