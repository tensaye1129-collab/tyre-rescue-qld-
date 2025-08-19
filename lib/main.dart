import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Contact details for call & email buttons
const String phoneNumber = '0466846785';
const String emailAddress = 'tensaye1129@gmail.com';

void main() => runApp(const TyreRescueApp());

class TyreRescueApp extends StatelessWidget {
  const TyreRescueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tyre Rescue QLD',
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

  // Open phone dialer
  Future<void> _callNumber() async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    }
  }

  // Open email app
  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: 'subject=Tyre Rescue QLD Support',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tyre Rescue QLD'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Tyre Rescue QLD!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _callNumber,
              icon: const Icon(Icons.phone),
              label: const Text('Call Us'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.email),
              label: const Text('Email Us'),
            ),
          ],
        ),
      ),
    );
  }
}
