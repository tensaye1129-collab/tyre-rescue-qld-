import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const TyreRescueApp());
}

class TyreRescueApp extends StatelessWidget {
  const TyreRescueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tyre Rescue QLD',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Phone and email
  final String phoneNumber = "0466846785";
  final String email = "tensaye1129@gmail.com";

  Future<void> _callNumber() async {
    final Uri callUri = Uri(scheme: "tel", path: "0466846785");
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: "mailto",
      path: "tensaye1129@gmail.com",
      query: "subject=Tyre Rescue QLD Service&body=Hello, I need help with...",
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tyre Rescue QLD"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Tyre Rescue QLD 🚗",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: _callNumber,
              icon: const Icon(Icons.phone),
              label: const Text("Call Us"),
            ),
            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.email),
              label: const Text("Email Us"),
            ),
            const SizedBox(height: 30),

            const Text(
              "We provide:\n• Tyre change\n• Fuel delivery\n• Jump start\n• Battery replacement\n\n24/7 Service - Day & Night",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
