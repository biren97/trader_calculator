enum PeriodType { monthly, yearly }

class CompoundRow {
  const CompoundRow({
    required this.label,
    required this.principal,
    required this.interest,
    required this.amount,
  });

  final String label;
  final double principal;
  final double interest;
  final double amount;
}

class CompoundResult {
  const CompoundResult({
    required this.rows,
    required this.initialPrincipal,
    required this.totalInterest,
    required this.finalAmount,
  });

  final List<CompoundRow> rows;
  final double initialPrincipal;
  final double totalInterest;
  final double finalAmount;
}

/// Compounds [principal] over [months] at [annualRatePercent].
///
/// Monthly: one row per month at rate/12. Yearly: one row per year at the full
/// rate; a leftover part-year gets a last row with the rate scaled by the
/// months it covers. Each period's interest is added to the next principal.
CompoundResult calculateCompound({
  required double principal,
  required double annualRatePercent,
  required int months,
  required PeriodType type,
}) {
  final annual = annualRatePercent / 100;
  final rows = <CompoundRow>[];
  var current = principal;

  if (type == PeriodType.monthly) {
    for (var m = 1; m <= months; m++) {
      final interest = current * annual / 12;
      rows.add(CompoundRow(
        label: '$m',
        principal: current,
        interest: interest,
        amount: current + interest,
      ));
      current += interest;
    }
  } else {
    final full = months ~/ 12;
    final rest = months % 12;
    for (var y = 1; y <= full; y++) {
      final interest = current * annual;
      rows.add(CompoundRow(
        label: '$y',
        principal: current,
        interest: interest,
        amount: current + interest,
      ));
      current += interest;
    }
    if (rest > 0) {
      final interest = current * annual * rest / 12;
      rows.add(CompoundRow(
        label: '${full + 1} (${rest}m)',
        principal: current,
        interest: interest,
        amount: current + interest,
      ));
      current += interest;
    }
  }

  return CompoundResult(
    rows: rows,
    initialPrincipal: principal,
    totalInterest: current - principal,
    finalAmount: current,
  );
}
