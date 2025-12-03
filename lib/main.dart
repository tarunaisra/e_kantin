import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:smart_ekantin/screens/home_screen.dart';
import 'services/seed_services.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/cart_screen.dart';
import 'widgets/loading_indicator.dart';
import 'providers/cart_provider.dart';

Future<void> main_taruna() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Dev-only: seed Firestore with sample products for local development
  if (kDebugMode) {
    try {
      await SeedService().seedProducts();
      // ignore: avoid_print
      print('Dev seed: products seeded');
    } catch (e) {
      // ignore: avoid_print
      print('Dev seed failed: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider_taruna(),
        ),
      ],
      child: MaterialApp(
        title: 'E-Kantin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const WelcomeScreen(),
        routes: {
          '/login': (context) => const LoginScreen_Yogi(),
          '/register': (context) => const RegisterScreen_Yogi(),
          '/home': (context) => const HomeScreen_Yogi(), // pilih yang dari main karena ini pembagian tugas
          '/cart': (context) => const CartScreen_taruna(),
          LoadingIndicator_Rapli.routeName_Rapli: (context) => const LoadingIndicator_Rapli(),
        },
      ),
    );
  }
}




// WelcomeScreen yang lebih modern, menarik, dan fokus pada E-Kantin
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _scaleController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _scaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: const Text(
                      'Selamat Datang di E-Kantin!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pesan makanan favoritmu dengan mudah, cepat, dan aman. Nikmati pengalaman kuliner kampus yang modern!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    label: const Text(
                      'MULAI PESAN SEKARANG',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 15,
                      shadowColor: Colors.orange.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      SizedBox(width: 5),
                      Text(
                        'Mudah • Cepat • Aman',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

