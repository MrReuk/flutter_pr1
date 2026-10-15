sealed class CalcResult {
  const CalcResult();
}

class CalcSuccess extends CalcResult {
  final double value;
  const CalcSuccess(this.value);
}

class CalcFailure extends CalcResult {
  final String message;
  const CalcFailure(this.message);
}

double? parseNumber(String? raw) {
  if (raw == null) return null;
  final value = double.tryParse(raw.trim().replaceAll(',', '.'));
  if (value == null || !value.isFinite) return null;
  return value;
}

String formatNumber(double value, {int fractionDigits = 6}) {
  var text = value.toStringAsFixed(fractionDigits);
  if (text.contains('.')) {
    text = text.replaceAll(RegExp(r'0+$'), '');
    text = text.replaceAll(RegExp(r'\.$'), '');
  }
  if (text == '-0') return '0';
  return text;
}

CalcResult calculate(String? rawA, String? rawOp, String? rawB) {
  if (rawA == null || rawOp == null || rawB == null) {
    return const CalcFailure('В адресе не хватает параметров (нужны a, op и b)');
  }

  final a = parseNumber(rawA);
  final b = parseNumber(rawB);
  if (a == null || b == null) {
    return const CalcFailure('В адресе переданы не числа');
  }

  final CalcResult result = switch (rawOp) {
    '+' => CalcSuccess(a + b),
    '-' => CalcSuccess(a - b),
    '*' => CalcSuccess(a * b),
    '/' => b == 0
        ? const CalcFailure('Деление на ноль невозможно')
        : CalcSuccess(a / b),
    _ => const CalcFailure('Неизвестная операция'),
  };

  if (result is CalcSuccess && !result.value.isFinite) {
    return const CalcFailure('Результат слишком большой');
  }
  return result;
}
