import 'package:app_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttons = [
      _buildNavButton(Icons.insights, "Strategia", AppRoutes.strategy, context),
      _buildNavButton(
        Icons.bar_chart,
        "Valore Economico",
        AppRoutes.economic,
        context,
      ),
      _buildNavButton(Icons.school, "Didattica", AppRoutes.teaching, context),
      _buildNavButton(Icons.science, "Ricerca", AppRoutes.research, context),
      _buildNavButton(Icons.people, "Persone", AppRoutes.people, context),
      _buildNavButton(Icons.diversity_3, "Società", AppRoutes.society, context),
      _buildNavButton(
        Icons.energy_savings_leaf,
        "Ambiente",
        AppRoutes.environment,
        context,
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Benvenuto nel tool di visualizzazione dei dati universitari.",
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "Seleziona la categoria che ti interessa.",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: buttons,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.smart_toy),
      ),
    );
  }

  Widget _buildNavButton(
    IconData icon,
    String label,
    String route,
    BuildContext context,
  ) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label, textAlign: TextAlign.center),
        onPressed: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
