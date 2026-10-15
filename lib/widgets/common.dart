import 'package:flutter/material.dart';

import '../logic/settings.dart';

class CenteredBody extends StatelessWidget {
  const CenteredBody({super.key, required this.child, this.maxWidth = 420});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (context, mode, _) {
        return IconButton(
          tooltip: 'Сменить тему',
          icon: Icon(mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
          onPressed: AppSettings.toggleTheme,
        );
      },
    );
  }
}
