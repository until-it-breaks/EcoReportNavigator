import 'package:app_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Benvenuto")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Benvenuto nel tool di visualizzazione dei dati universitari",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.insights),
              label: const Text("Vai alla Strategia"),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.strategy),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.bar_chart),
              label: const Text("Vai al Valore Economico"),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.economic),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.school),
              label: const Text("Vai alla Didattica"),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.teaching),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.chat),
              label: const Text("Chat AI"),
              onPressed: () => Navigator.pushNamed(context, '/chat'),
            ),
          ],
        ),
      ),
    );
  }
}
