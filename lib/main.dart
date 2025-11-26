import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product_model.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProviderTaruna()),
      ],
      child: const MyAppTaruna(),
    ),
  );
}

class MyAppTaruna extends StatelessWidget {
  const MyAppTaruna({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart E-Kantin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePageTaruna(),
    );
  }
}

class HomePageTaruna extends StatefulWidget {
  const HomePageTaruna({super.key});

  @override
  State<HomePageTaruna> createState() => _HomePageTarunaState();
}

class _HomePageTarunaState extends State<HomePageTaruna> {
  List<ProductModel> productsTaruna = [
    ProductModel(productId: "1", name: "Nasi Goreng", price: 15000, stock: 20, imageUrl: "https://via.placeholder.com/100?text=Nasi+Goreng"),
    ProductModel(productId: "2", name: "Ayam Geprek", price: 14000, stock: 15, imageUrl: "https://via.placeholder.com/100?text=Ayam+Geprek"),
    ProductModel(productId: "3", name: "Soto Ayam", price: 12000, stock: 25, imageUrl: "https://via.placeholder.com/100?text=Soto+Ayam"),
  ];
  final bool isAdminTaruna = true;

  void editProductTaruna(ProductModel product, double newPrice, int newStock) {
    setState(() {
      final idx = productsTaruna.indexWhere((p) => p.productId == product.productId);
      if (idx != -1) {
        productsTaruna[idx] = ProductModel(
          productId: product.productId,
          name: product.name,
          price: newPrice,
          stock: newStock,
          imageUrl: product.imageUrl,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart E-Kantin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPageTaruna()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productsTaruna.length,
        itemBuilder: (context, index) {
          final productTaruna = productsTaruna[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(productTaruna.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(productTaruna.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Harga: Rp${productTaruna.price.toStringAsFixed(0)}', style: const TextStyle(color: Colors.green)),
                  Text('Stok: ${productTaruna.stock}', style: const TextStyle(color: Colors.blue)),
                ],
              ),
              trailing: isAdminTaruna
                  ? IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditProductDialogTaruna(
                            product: productTaruna,
                            onSave: (newPrice, newStock) {
                              editProductTaruna(productTaruna, newPrice, newStock);
                            },
                          ),
                        );
                      },
                    )
                  : ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {
                        Provider.of<CartProviderTaruna>(context, listen: false).addToCartTaruna(productTaruna);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${productTaruna.name} ditambahkan ke keranjang')),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

class EditProductDialogTaruna extends StatefulWidget {
  final ProductModel product;
  final Function(double, int) onSave;
  const EditProductDialogTaruna({super.key, required this.product, required this.onSave});

  @override
  State<EditProductDialogTaruna> createState() => _EditProductDialogTarunaState();
}

class _EditProductDialogTarunaState extends State<EditProductDialogTaruna> {
  late TextEditingController priceControllerTaruna;
  late TextEditingController stockControllerTaruna;

  @override
  void initState() {
    super.initState();
    priceControllerTaruna = TextEditingController(text: widget.product.price.toStringAsFixed(0));
    stockControllerTaruna = TextEditingController(text: widget.product.stock.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit ${widget.product.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: priceControllerTaruna,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Harga'),
          ),
          TextField(
            controller: stockControllerTaruna,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Stok'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Batal'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('Simpan'),
          onPressed: () {
            final newPriceTaruna = double.tryParse(priceControllerTaruna.text) ?? widget.product.price;
            final newStockTaruna = int.tryParse(stockControllerTaruna.text) ?? widget.product.stock;
            widget.onSave(newPriceTaruna, newStockTaruna);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Perubahan disimpan!')),
            );
          },
        ),
      ],
    );
  }
}

class CartPageTaruna extends StatelessWidget {
  const CartPageTaruna({super.key});

  @override
  Widget build(BuildContext context) {
    final cartTaruna = Provider.of<CartProviderTaruna>(context);
    final nimTaruna = "2141720123"; // Ganti dengan NIM user login
    final lastDigitTaruna = int.parse(nimTaruna[nimTaruna.length - 1]);
    final gratisOngkirTaruna = lastDigitTaruna % 2 == 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartTaruna.cartItemsTaruna.length,
              itemBuilder: (context, index) {
                final itemTaruna = cartTaruna.cartItemsTaruna[index];
                return ListTile(
                  title: Text(itemTaruna.name),
                  subtitle: Text('Rp${itemTaruna.price.toStringAsFixed(0)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartTaruna.removeFromCartTaruna(itemTaruna.productId);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total: Rp${cartTaruna.totalPriceTaruna.toStringAsFixed(0)}'),
                Text(gratisOngkirTaruna ? 'Gratis Ongkir!' : 'Diskon: Rp${cartTaruna.hitungDiskonSari(nimTaruna).toStringAsFixed(0)}'),
                Text('Final: Rp${cartTaruna.getFinalPriceTaruna(nimTaruna).toStringAsFixed(0)}'),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Checkout'),
                  onPressed: () async {
                    await cartTaruna.checkoutTaruna(nimTaruna);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checkout berhasil!')),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
