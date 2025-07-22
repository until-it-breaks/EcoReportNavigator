import "package:insightviewer/core/app_chapter.dart";
import "package:insightviewer/main.dart";
import "package:insightviewer/ui/widgets/theme_toggle_button.dart";
import "package:flutter/material.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttons = [
      _buildNavButton(context, AppChapter.strategy),
      _buildNavButton(context, AppChapter.economic),
      _buildNavButton(context, AppChapter.teaching),
      _buildNavButton(context, AppChapter.research),
      _buildNavButton(context, AppChapter.people),
      _buildNavButton(context, AppChapter.society),
      _buildNavButton(context, AppChapter.environment),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 48),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ThemeToggleButton(themeNotifier: themeNotifier),
                ),
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
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, AppChapter category) {
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
