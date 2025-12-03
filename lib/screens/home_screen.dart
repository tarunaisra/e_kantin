import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product_model.dart';

class HomeScreen_Yogi extends StatefulWidget {
  const HomeScreen_Yogi({super.key});

  @override
  State<HomeScreen_Yogi> createState() => _HomeScreenState_Yogi();
}

class _HomeScreenState_Yogi extends State<HomeScreen_Yogi>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<ProductModel_taruna> products_Yogi = [
    ProductModel_taruna(
      productId: '1',
      name: 'Nasi Goreng',
      price: 15000,
      stock: 20,
      imageUrl: 'assets/images/nasi_goreng.jpg',
    ),
    ProductModel_taruna(
      productId: '2',
      name: 'Sate Kambing',
      price: 35000,
      stock: 15,
      imageUrl: 'assets/images/sate_kambing.jpg',
    ),
    ProductModel_taruna(
      productId: '3',
      name: 'Soto Ayam',
      price: 20000,
      stock: 25,
      imageUrl: 'assets/images/soto_ayam.jpg',
    ),
    ProductModel_taruna(
      productId: '4',
      name: 'Rujak Lontong',
      price: 12000,
      stock: 18,
      imageUrl: 'assets/images/rujak_lontong.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar transparan
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003366), Color(0xFF000033)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: ListView.builder(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight + 25,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            itemCount: products_Yogi.length,
            itemBuilder: (context, index) {
              final product = products_Yogi[index];
              final price =
                  'Rp ${product.price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Card(
                  color: Colors.white.withOpacity(0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),

                    // gambar dari produk
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        product.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Harga: $price | Stok: ${product.stock}',
                      style: const TextStyle(color: Colors.white70),
                    ),

                    trailing: ElevatedButton(
                      onPressed: product.stock > 0
                          ? () {
                              // Add to cart using provider
                              Provider.of<CartProvider_taruna>(context, listen: false)
                                  .addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} ditambahkan ke keranjang',
                                  ),
                                  backgroundColor: const Color(0xFF003366),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: product.stock > 0 ? Colors.white : Colors.grey,
                        foregroundColor: const Color(0xFF003366),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                      ),
                      child: Text(product.stock > 0 ? 'Tambah' : 'Habis'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
