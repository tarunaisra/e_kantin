import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'payment_success_screen.dart';
import '../services/auth_service.dart';
import '../providers/cart_provider.dart';
import '../models/product_model.dart';

class CartScreen_taruna extends StatefulWidget {
  const CartScreen_taruna({super.key});

  @override
  State<CartScreen_taruna> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen_taruna>
    with SingleTickerProviderStateMixin {
  final AuthService_Rapli _authService = AuthService_Rapli();
  String? _userNim_taruna;

  late AnimationController _cartAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadUserNim_taruna();

    _cartAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 220),
      lowerBound: 0.96,
      upperBound: 1.05,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _cartAnimation,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _cartAnimation.dispose();
    super.dispose();
  }

  Future<void> _loadUserNim_taruna() async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser?.email;
      if (userEmail != null) {
        final nim = await _authService.getUserNimByEmail_Rapli(userEmail);
        if (mounted) {
          setState(() => _userNim_taruna = nim);
        }
      }
    } catch (e) {
      print('Error loading NIM: $e');
    }
  }

  String pickupTime = 'Sekarang';
  final List<String> pickupOptions = ['Sekarang', '12:00', '12:30', '13:00'];
  void _selectPickupTime(String time) => setState(() => pickupTime = time);

  void _proceedToCheckout() {
    if (_userNim_taruna == null || _userNim_taruna!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'NIM tidak ditemukan. Silakan logout dan login kembali.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen_Rapli(
          nim_Rapli: _userNim_taruna!,
          pickupTime_Rapli: pickupTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Pesanan Saya',
          style: TextStyle(color: Colors.white),
        ),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003366), Color(0xFF000033)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<CartProvider_taruna>(
          builder: (context, provider, _) {
            final items = provider.cartItems;
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'Keranjang kosong',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            // Group by product
            final Map<String, Map<String, dynamic>> grouped = {};
            for (var it in items) {
              final key = it.productId;
              if (!grouped.containsKey(key)) {
                grouped[key] = {'product': it, 'quantity': 1};
              } else {
                grouped[key]!['quantity'] = grouped[key]!['quantity'] + 1;
              }
            }
            final groupedList = grouped.values.toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      top: kToolbarHeight + 20,
                      left: 16,
                      right: 16,
                    ),
                    itemCount: groupedList.length,
                    itemBuilder: (context, index) {
                      final entry = groupedList[index];
                      final ProductModel_taruna product = entry['product'];
                      final int quantity = entry['quantity'];

                      return ScaleTransition(
                        scale: _scaleAnimation,
                        child: Card(
                          color: Colors.white.withOpacity(0.1),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(product.imageUrl),
                              radius: 30,
                            ),
                            title: Text(
                              product.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Rp ${product.price.toInt()} x $quantity',
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    provider.removeFromCart(product.productId);
                                    _cartAnimation.forward(from: 0.96);
                                  },
                                ),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    provider.addToCart(product);
                                    _cartAnimation.forward(from: 0.96);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    for (int i = 0; i < quantity; i++) {
                                      provider.removeFromCart(
                                        product.productId,
                                      );
                                    }
                                    _cartAnimation.forward(from: 0.96);
                                  },
                                ),
                              ],
                            ),
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
                        'Total: Rp ${provider.totalPrice.toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _proceedToCheckout,
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
            );
          },
        ),
      ),
    );
  }
}
