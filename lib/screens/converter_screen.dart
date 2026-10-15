import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../logic/calculator.dart';
import '../logic/currency.dart';
import '../logic/settings.dart';
import '../widgets/common.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  String _from = AppSettings.fromCurrency;
  String _to = AppSettings.toCurrency;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _amountValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введите сумму';
    final amount = parseNumber(value);
    if (amount == null) return 'Это не число';
    if (amount < 0) return 'Сумма не может быть отрицательной';
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final location = Uri(
      path: '/converter/result',
      queryParameters: {
        'amount': _amountController.text.trim().replaceAll(',', '.'),
        'from': _from,
        'to': _to,
      },
    ).toString();
    context.go(location);
  }

  Widget _currencyDropdown({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: currencyRates.keys
          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конвертер валют'),
        leading: BackButton(onPressed: () => context.go('/')),
        actions: const [ThemeButton()],
      ),
      body: CenteredBody(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _currencyDropdown(
                label: 'Из валюты',
                value: _from,
                onChanged: (v) {
                  setState(() => _from = v);
                  AppSettings.saveCurrencies(_from, _to);
                },
              ),
              const SizedBox(height: 16),
              _currencyDropdown(
                label: 'В валюту',
                value: _to,
                onChanged: (v) {
                  setState(() => _to = v);
                  AppSettings.saveCurrencies(_from, _to);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Сумма',
                  border: OutlineInputBorder(),
                ),
                validator: _amountValidator,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submit,
                child: const Text('Конвертировать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
