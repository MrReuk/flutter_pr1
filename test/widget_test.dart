import 'package:calc_web/screens/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Экран 404 показывает неизвестный адрес', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: NotFoundScreen(location: '/qwerty')),
    );

    expect(find.text('/qwerty'), findsOneWidget);
    expect(find.text('На главную'), findsOneWidget);
  });
}
