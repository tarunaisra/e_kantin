import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // ---------- DAFTAR PRODUK + GAMBAR ----------
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Nasi Goreng',
      'price': 15000,
      'image': 'assets/images/nasi_goreng.jpg',
    },
    {
      'name': 'Sate Kambing',
      'price': 35000,
      'image': 'assets/images/sate_kambing.jpg',
    },
    {
      'name': 'Soto Ayam',
      'price': 20000,
      'image': 'assets/images/soto_ayam.jpg',
    },
    {
      'name': 'Rujak Lontong',
      'price': 12000,
      'image': 'assets/images/rujak_lontong.jpg',
    },
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
      // ---- APPBAR TRANSPARAN ----
      appBar: AppBar(
        title: const Text(
          'e-Kantin',
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
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final price =
                  'Rp ${product['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

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

                    // ------------ GAMBAR PRODUK ------------
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        product['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Text(
                      product['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Harga: $price',
                      style: const TextStyle(color: Colors.white70),
                    ),

                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product['name']} ditambahkan ke keranjang',
                            ),
                            backgroundColor: const Color(0xFF003366),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF003366),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                      ),
                      child: const Text('Tambah'),
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
