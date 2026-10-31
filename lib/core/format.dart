/// Groups digits the Indian way: 12,34,567.
String _group(String digits) {
  if (digits.length <= 3) return digits;
  final last3 = digits.substring(digits.length - 3);
  final rest = digits.substring(0, digits.length - 3);
  final b = StringBuffer();
  for (var i = 0; i < rest.length; i++) {
    if (i > 0 && (rest.length - i) % 2 == 0) b.write(',');
    b.write(rest[i]);
  }
  return '$b,$last3';
}

String formatNumber(num v, {int decimals = 0}) {
  final s = v.abs().toStringAsFixed(decimals).split('.');
  final sign = v < 0 && double.parse(v.abs().toStringAsFixed(decimals)) != 0
      ? '-'
      : '';
  final frac = s.length > 1 ? '.${s[1]}' : '';
  return '$sign${_group(s[0])}$frac';
}

String formatMoney(num v, {int decimals = 2}) {
  final n = formatNumber(v, decimals: decimals);
  return n.startsWith('-') ? '-₹${n.substring(1)}' : '₹$n';
}

double? parseNum(String? s) => double.tryParse((s ?? '').trim());
