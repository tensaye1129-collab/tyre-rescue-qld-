import 'package:flutter/material.dart';

void main() {
  runApp(const TyreRescueApp());
}

class TyreRescueApp extends StatelessWidget {
  const TyreRescueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tyre Rescue QLD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tyre Rescue QLD'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Tyre Rescue QLD',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '24/7 Mobile Tyre, Battery, Fuel & Jump Start Service',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
