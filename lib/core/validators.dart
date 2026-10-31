import 'format.dart';

String? positive(String? v) {
  final n = parseNum(v);
  if (n == null) return 'Required';
  if (n <= 0) return 'Must be greater than 0';
  return null;
}

String? nonNegative(String? v) {
  final n = parseNum(v);
  if (n == null) return 'Required';
  if (n < 0) return 'Cannot be negative';
  return null;
}

String? Function(String?) wholeBetween(int min, int max) => (v) {
      final n = parseNum(v);
      if (n == null) return 'Required';
      if (n != n.roundToDouble() || n < min || n > max) {
        return 'Enter a whole number from $min to $max';
      }
      return null;
    };
