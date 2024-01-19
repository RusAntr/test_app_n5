import 'package:intl/intl.dart';

/// Formats number to a currency pattern. Returns a string
extension CurrencyExtension on num {
  String currency() {
    NumberFormat formatter =
        NumberFormat.currency(locale: 'RU_ru', symbol: '', decimalDigits: 0);
    return formatter.format(this);
  }
}

/// Returns plural (RU_ru) from a given number
extension RuPlurals on num {
  String ruPlural(List<String> words) {
    if (this % 10 == 1 && this % 100 != 11) {
      return '$this ${words[2]}';
    } else if (this % 10 >= 2 &&
        this % 10 <= 4 &&
        (this % 100 < 10 || this % 100 >= 20)) {
      return '$this ${words[1]}';
    } else {
      return '$this ${words[0]}';
    }
  }
}

/// Simple email validator
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

/// Simple date validator
/// Accepted range starts at 1900y
extension DateValidator on String {
  /// Date validation
  bool isValidDate() {
    if (length == 10) {
      var day = int.parse(substring(0, 2));
      var month = int.parse(substring(3, 5));
      var year = int.parse(substring(6, 10));

      DateTime enteredDateTime =
          DateFormat('dd-MM-yyyy').parse('$day-$month-$year');
      if (day < 32 && month < 13 && (year < 2024 && year > 1900)) {
        var differenceDays = DateTime.now().difference(enteredDateTime).inDays;
        var nowDays = const Duration(days: 365 * 16).inDays;
        if (differenceDays < nowDays) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
