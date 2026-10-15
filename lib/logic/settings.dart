import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'currency.dart';

class AppSettings {
  static late SharedPreferences _prefs;

  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.light);
  static String fromCurrency = 'USD';
  static String toCurrency = 'EUR';

  static Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();

    themeMode.value =
        _prefs.getBool('dark') == true ? ThemeMode.dark : ThemeMode.light;

    final from = _prefs.getString('from');
    final to = _prefs.getString('to');
    if (from != null && currencyRates.containsKey(from)) fromCurrency = from;
    if (to != null && currencyRates.containsKey(to)) toCurrency = to;
  }

  static void toggleTheme() {
    final dark = themeMode.value != ThemeMode.dark;
    themeMode.value = dark ? ThemeMode.dark : ThemeMode.light;
    _prefs.setBool('dark', dark);
  }

  static void saveCurrencies(String from, String to) {
    fromCurrency = from;
    toCurrency = to;
    _prefs.setString('from', from);
    _prefs.setString('to', to);
  }
}
