import 'package:flutter/material.dart';
import 'routes/app_routes_bac.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyAppBac());
}

class MyAppBac extends StatelessWidget {
  const MyAppBac({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart E-Kantin',
      debugShowCheckedModeBanner: false,

      // Halaman awal (Login)
      initialRoute: '/login',

      // Routing yang didefinisikan di AppRoutesBac
      routes: AppRoutesBac.routes,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
