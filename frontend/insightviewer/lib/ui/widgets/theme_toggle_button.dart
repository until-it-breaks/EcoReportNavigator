import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const ThemeToggleButton({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        final brightness = MediaQuery.platformBrightnessOf(context);
        final isDark = switch (mode) {
          ThemeMode.system => brightness == Brightness.dark,
          ThemeMode.dark => true,
          ThemeMode.light => false,
        };

        return IconButton(
          icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          onPressed: () {
            themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
          },
        );
      },
    );
  }
}
