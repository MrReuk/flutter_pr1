import 'package:calc_web/logic/calculator.dart';
import 'package:calc_web/logic/currency.dart';
import 'package:flutter_test/flutter_test.dart';

Matcher failureWith(String text) => isA<CalcFailure>()
    .having((f) => f.message, 'message', contains(text));

Matcher successOf(double value) => isA<CalcSuccess>()
    .having((s) => s.value, 'value', closeTo(value, 1e-9));

void main() {
  group('calculate', () {
    test('сложение', () {
      expect(calculate('2', '+', '3'), successOf(5));
    });

    test('вычитание', () {
      expect(calculate('2', '-', '3'), successOf(-1));
    });

    test('умножение', () {
      expect(calculate('4', '*', '2.5'), successOf(10));
    });

    test('деление', () {
      expect(calculate('10', '/', '4'), successOf(2.5));
    });

    test('запятая как десятичный разделитель', () {
      expect(calculate('1,5', '+', '2'), successOf(3.5));
    });

    test('деление на ноль', () {
      expect(calculate('5', '/', '0'), failureWith('Деление на ноль'));
    });

    test('нечисловой ввод', () {
      expect(calculate('abc', '+', '1'), failureWith('не числа'));
    });

    test('неизвестная операция', () {
      expect(calculate('1', '^', '2'), failureWith('Неизвестная операция'));
    });

    test('отсутствует параметр', () {
      expect(calculate(null, '+', '2'), failureWith('не хватает'));
    });
  });

  group('formatNumber', () {
    test('округляет бесконечную дробь', () {
      expect(formatNumber(10 / 3), '3.333333');
    });

    test('убирает лишние нули и погрешность', () {
      expect(formatNumber(0.1 + 0.2), '0.3');
      expect(formatNumber(5.0), '5');
    });
  });

  group('convert', () {
    test('USD в EUR', () {
      expect(convert('100', 'USD', 'EUR'), successOf(92));
    });

    test('неизвестная валюта', () {
      expect(convert('100', 'USD', 'XXX'), failureWith('неизвестная валюта'));
    });

    test('отрицательная сумма', () {
      expect(convert('-5', 'USD', 'EUR'), failureWith('отрицательной'));
    });

    test('сумма не число', () {
      expect(convert('abc', 'USD', 'EUR'), failureWith('не число'));
    });
  });
}
