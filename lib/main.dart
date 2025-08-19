import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// === Your business details ===
const String businessName = 'Tyre Rescue QLD';
const String phoneNumber = '0466846785'; // change if needed
const String emailAddress = 'tensaye1129collab@gmail.com'; // change if needed

void main() => runApp(const TyreRescueApp());

class TyreRescueApp extends StatelessWidget {
  const TyreRescueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: businessName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // --- actions ---
  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _email() async {
    final uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {'subject': '$businessName enquiry'},
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openMaps() async {
    // This opens Google Maps to search for your business name
    final query = Uri.encodeComponent(businessName);
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(businessName)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- LOGO ---
              // Make sure pubspec.yaml has:
              // flutter:
              //   uses-material-design: true
              //   assets:
              //     - assets/logo.png
              Image.asset(
                'assets/logo.png',
                height: 140,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                'Fast roadside tyre help across QLD',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // --- BUTTONS ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.call),
                  label: const Text('Call now'),
                  onPressed: _call,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.email),
                  label: const Text('Email us'),
                  onPressed: _email,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('Open in Google Maps'),
                  onPressed: _openMaps,
                ),
              ),

              const SizedBox(height: 24),
              Text(
                '© ${DateTime.now().year} $businessName',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
