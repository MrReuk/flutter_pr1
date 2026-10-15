import 'calculator.dart';

const Map<String, double> currencyRates = {
  'USD': 1.0,
  'EUR': 0.92,
  'GBP': 0.79,
  'RUB': 95.0,
  'JPY': 150.0,
  'CNY': 7.2,
};

CalcResult convert(String? rawAmount, String? from, String? to) {
  if (rawAmount == null || from == null || to == null) {
    return const CalcFailure(
        'В адресе не хватает параметров (нужны amount, from и to)');
  }

  final amount = parseNumber(rawAmount);
  if (amount == null) {
    return const CalcFailure('Сумма в адресе — не число');
  }
  if (amount < 0) {
    return const CalcFailure('Сумма не может быть отрицательной');
  }

  final rateFrom = currencyRates[from];
  final rateTo = currencyRates[to];
  if (rateFrom == null || rateTo == null) {
    return const CalcFailure('В адресе указана неизвестная валюта');
  }

  final value = amount / rateFrom * rateTo;
  if (!value.isFinite) return const CalcFailure('Результат слишком большой');
  return CalcSuccess(value);
}
