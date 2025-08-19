import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const TyreRescueApp());

// ===== BRAND + CONTACT (edit if needed) =========================
class Brand {
  static const navy   = Color(0xFF0B2847);
  static const orange = Color(0xFFFF7A00);
  static const bg     = Color(0xFFF6F8FB);
}

class Contact {
  static const phoneE164 = '+61466846785'; // WhatsApp needs intl format
  static const phoneDial = '0466846785';   // shown to users
  static const email     = 'support@tyrerescueqld.com.au';
  static const address   = 'Brisbane, QLD';

  static Uri get tel      => Uri.parse('tel:$phoneDial');
  static Uri get sms      => Uri.parse('sms:$phoneDial');
  static Uri get emailUri => Uri.parse('mailto:$email?subject=Tyre%20Rescue%20QLD%20Support');
  static Uri get whatsapp => Uri.parse('https://wa.me/${phoneE164.replaceAll('+', '')}');
  static Uri get maps     => Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');
}
// ===============================================================

class TyreRescueApp extends StatelessWidget {
  const TyreRescueApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tyre Rescue QLD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Brand.orange, primary: Brand.navy),
        scaffoldBackgroundColor: Brand.bg,
      ),
      home: const HomePage(),
      routes: {
        SupportScreen.route: (_) => const SupportScreen(),
        AssistantScreen.route: (_) => const AssistantScreen(),
      },
    );
  }
}

// ======================= HOME =======================
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Future<void> _open(Uri u) async { if (await canLaunchUrl(u)) await launchUrl(u, mode: LaunchMode.externalApplication); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tyre Rescue QLD'), actions: [
        IconButton(icon: const Icon(Icons.support_agent_outlined),
          onPressed: () => Navigator.pushNamed(context, SupportScreen.route)),
        IconButton(icon: const Icon(Icons.help_outline),
          onPressed: () => Navigator.pushNamed(context, AssistantScreen.route)),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('🚗 24/7 Mobile Tyre & Roadside Help',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Tyre change • Fuel delivery • Jump start • Battery'),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _open(Contact.tel),
              icon: const Icon(Icons.phone),
              label: Text('Call us now  (${Contact.phoneDial})'),
            ),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: OutlinedButton.icon(
              onPressed: () => _open(Contact.sms),
              icon: const Icon(Icons.sms_outlined), label: const Text('SMS'),
            )),
            const SizedBox(width: 10),
            Expanded(child: OutlinedButton.icon(
              onPressed: () => _open(Contact.whatsapp),
              icon: const Icon(Icons.whatsapp), label: const Text('WhatsApp'),
            )),
          ]),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AssistantScreen.route),
            icon: const Icon(Icons.smart_toy_outlined),
            label: const Text('Help / AI Answers'),
          ),
        ]),
      ),
    );
  }
}

// ===================== SUPPORT ======================
class SupportScreen extends StatelessWidget {
  static const route = '/support';
  const SupportScreen({super.key});
  Future<void> _open(Uri u) async { if (await canLaunchUrl(u)) await launchUrl(u, mode: LaunchMode.externalApplication); }

  @override
  Widget build(BuildContext context) {
    final infoStyle = TextStyle(color: Colors.black.withOpacity(.7));
    return Scaffold(
      appBar: AppBar(title: const Text('Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(child: ListTile(leading: const Icon(Icons.phone), title: const Text('Call'),
            subtitle: Text(Contact.phoneDial, style: infoStyle), trailing: const Icon(Icons.chevron_right),
            onTap: () => _open(Contact.tel))),
          Card(child: ListTile(leading: const Icon(Icons.sms_outlined), title: const Text('Send SMS'),
            subtitle: Text(Contact.phoneDial, style: infoStyle), trailing: const Icon(Icons.chevron_right),
            onTap: () => _open(Contact.sms))),
          Card(child: ListTile(leading: const Icon(Icons.whatsapp), title: const Text('WhatsApp'),
            subtitle: Text(Contact.phoneE164, style: infoStyle), trailing: const Icon(Icons.chevron_right),
            onTap: () => _open(Contact.whatsapp))),
          Card(child: ListTile(leading: const Icon(Icons.email_outlined), title: const Text('Email'),
            subtitle: Text(Contact.email, style: infoStyle), trailing: const Icon(Icons.chevron_right),
            onTap: () => _open(Contact.emailUri))),
          Card(child: ListTile(leading: const Icon(Icons.location_on_outlined), title: const Text('Service area'),
            subtitle: Text(Contact.address, style: infoStyle), trailing: const Icon(Icons.chevron_right),
            onTap: () => _open(Contact.maps))),
          const SizedBox(height: 12),
          const Text('Hours', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('Open 24/7 • Response time varies by area'),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AssistantScreen.route),
            icon: const Icon(Icons.smart_toy_outlined),
            label: const Text('Need quick answers? Ask the AI helper'),
          ),
        ),
      ),
    );
  }
}

// ============== AI HELPER (OFFLINE) =================
// Small FAQ and keyword match. Upgradeable later to a real API.
class AssistantScreen extends StatefulWidget {
  static const route = '/assistant';
  const AssistantScreen({super.key});
  @override State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final _controller = TextEditingController();
  String _answer = 'Ask me anything about Tyre Rescue QLD.';

  // Mini FAQ base
  final Map<String, String> faqs = {
    'tyre change flat spare': 'We come to you and change your tyre on-site. If you don’t have a spare, we can assist and guide next steps.',
    'fuel delivery petrol diesel': 'We deliver 5–10L to get you moving. Final price includes callout + fuel.',
    'jump start battery': 'We can jump start most vehicles safely. If your battery is dead, we can fit a replacement.',
    'price pricing cost fee quote': 'Typical callout from \$29 + service fee. Night rate after 9pm adds 25%. We always confirm price before work.',
    'eta arrival time how long': 'Typical ETA is 30–60 minutes depending on location and traffic.',
    'area coverage brisbane qld': 'We serve Brisbane and surrounding QLD suburbs. Tell us your exact location when booking.',
    'after hours night rate': 'After 9:00 PM a 25% night rate applies. We’ll confirm the final quote before work.',
    'payment cash card stripe': 'You can pay by card or cash. We’ll send a final invoice/receipt.',
    'contact phone sms whatsapp email': 'Call ${Contact.phoneDial}, SMS the same number, WhatsApp ${Contact.phoneE164}, or email ${Contact.email}.',
  };

  String bestAnswer(String query) {
    final q = query.toLowerCase();
    int bestScore = 0; String? bestKey;
    for (final k in faqs.keys) {
      int score = 0;
      for (final w in k.split(' ')) {
        if (q.contains(w)) score++;
      }
      if (score > bestScore) { bestScore = score; bestKey = k; }
    }
    if (bestKey != null && bestScore > 0) return faqs[bestKey]!;
    return "I couldn’t find a perfect answer. You can contact us below, or try rephrasing your question.";
  }

  Future<void> _open(Uri u) async { if (await canLaunchUrl(u)) await launchUrl(u, mode: LaunchMode.externalApplication); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help / AI Answers')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Type your question…',
              hintText: 'e.g., How much is a tyre change at night?',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => setState(() => _answer = bestAnswer(_controller.text)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _answer = bestAnswer(_controller.text)),
              icon: const Icon(Icons.search),
              label: const Text('Get answer'),
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(_answer, style: const TextStyle(fontSize: 16)),
          ),
          const Spacer(),
          const Divider(),
          const Align(alignment: Alignment.centerLeft,
            child: Text('Contact us', style: TextStyle(fontWeight: FontWeight.w800))),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: () => _open(Contact.tel), icon: const Icon(Icons.phone), label: const Text('Call'))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(onPressed: () => _open(Contact.sms), icon: const Icon(Icons.sms_outlined), label: const Text('SMS'))),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: () => _open(Contact.whatsapp), icon: const Icon(Icons.whatsapp), label: const Text('WhatsApp'))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(onPressed: () => _open(Contact.emailUri), icon: const Icon(Icons.email_outlined), label: const Text('Email'))),
          ]),
        ]),
      ),
    );
  }
}
