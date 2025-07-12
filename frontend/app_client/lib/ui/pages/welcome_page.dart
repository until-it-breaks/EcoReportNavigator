import "package:app_client/core/data_categories.dart";
import "package:app_client/main.dart";
import "package:app_client/ui/widgets/theme_toggle_button.dart";
import "package:flutter/material.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttons = [
      _buildNavButton(context, DataCategory.strategy),
      _buildNavButton(context, DataCategory.economic),
      _buildNavButton(context, DataCategory.teaching),
      _buildNavButton(context, DataCategory.research),
      _buildNavButton(context, DataCategory.people),
      _buildNavButton(context, DataCategory.society),
      _buildNavButton(context, DataCategory.environment),
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [ThemeToggleButton(themeNotifier: themeNotifier)],
        actionsPadding: EdgeInsets.all(8),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: 48,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.8),
                      offset: const Offset(12, 12),
                      blurRadius: 16,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/icon/app_icon.png",
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Benvenuto nel tool di visualizzazione dei dati universitari.",
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Seleziona la categoria che ti interessa.",
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
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
    );
  }

  Widget _buildNavButton(BuildContext context, DataCategory category) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        icon: Icon(category.icon, size: 24),
        iconAlignment: IconAlignment.start,
        label: Text(category.name),
        onPressed: () => Navigator.pushNamed(context, category.route.path),
      ),
    );
  }
}
