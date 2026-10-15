import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../logic/calculator.dart';
import '../widgets/common.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.title,
    required this.expression,
    required this.result,
    required this.backPath,
    this.unit = '',
    this.fractionDigits = 6,
  });

  final String title;
  final String expression;
  final CalcResult result;
  final String backPath;
  final String unit;
  final int fractionDigits;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<Widget> content = switch (result) {
      CalcSuccess(:final value) => [
          Icon(Icons.check_circle, size: 56, color: scheme.primary),
          const SizedBox(height: 16),
          Text(expression,
              textAlign: TextAlign.center, style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            '${formatNumber(value, fractionDigits: fractionDigits)}$unit',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium,
          ),
        ],
      CalcFailure(:final message) => [
          Icon(Icons.error_outline, size: 56, color: scheme.error),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(color: scheme.error),
          ),
        ],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(onPressed: () => context.go(backPath)),
        actions: const [ThemeButton()],
      ),
      body: CenteredBody(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...content,
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => context.go(backPath),
              child: const Text('Назад к форме'),
            ),
          ],
        ),
      ),
    );
  }
}
