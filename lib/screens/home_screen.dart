import 'package:flutter/material.dart';

class HomeScreen_Yogi extends StatefulWidget {
  const HomeScreen_Yogi({super.key});

  @override
  State<HomeScreen_Yogi> createState() => _HomeScreenState_Yogi();
}

class _HomeScreenState_Yogi extends State<HomeScreen_Yogi>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Simulasi daftar produk
  final List<String> products = [
    'Nasi Goreng',
    'Sate Kambing',
    'Soto Ayam',
    'Rujak Lontong',
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
      appBar: AppBar(
        title: Text('Beranda'),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white.withOpacity(0.1), // perbaikan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(Icons.shopping_bag, color: Colors.white),
                  title: Text(
                    products[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Harga: Rp ${(index + 1) * 10000}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Simulasi tambah ke cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${products[index]} ditambahkan ke keranjang',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Tambah'),
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
