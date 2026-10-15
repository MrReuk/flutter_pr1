import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/common.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Страница не найдена'),
        actions: const [ThemeButton()],
      ),
      body: CenteredBody(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('404',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 8),
            const Text('Такой страницы нет:', textAlign: TextAlign.center),
            Text(location, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('На главную'),
            ),
          ],
        ),
      ),
    );
  }
}
