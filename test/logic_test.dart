import 'package:flutter_test/flutter_test.dart';
import 'package:tech_toolkit/core/format.dart';
import 'package:tech_toolkit/features/compound_interest/compound_interest_logic.dart';
import 'package:tech_toolkit/features/stock_average/stock_average_logic.dart';

void main() {
  group('stock average', () {
    test('averages two purchases', () {
      final r = calculateAverage(
        price1: 100,
        shares1: 10,
        price2: 80,
        shares2: 10,
      );
      expect(r.totalShares, 20);
      expect(r.totalInvestment, 1800);
      expect(r.averagePrice, 90);
      expect(r.change, -10);
    });
  });

  group('compound interest', () {
    test('monthly compounding for a year', () {
      final r = calculateCompound(
        principal: 10000,
        annualRatePercent: 12,
        months: 12,
        type: PeriodType.monthly,
      );
      expect(r.rows.length, 12);
      expect(r.finalAmount, closeTo(11268.25, 0.01));
      expect(r.rows[1].principal, closeTo(r.rows[0].amount, 1e-9));
      expect(r.totalInterest, closeTo(r.finalAmount - 10000, 1e-9));
    });

    test('yearly compounding for two years', () {
      final r = calculateCompound(
        principal: 10000,
        annualRatePercent: 10,
        months: 24,
        type: PeriodType.yearly,
      );
      expect(r.rows.length, 2);
      expect(r.finalAmount, closeTo(12100, 1e-6));
      expect(r.totalInterest, closeTo(2100, 1e-6));
    });

    test('yearly with a part year adds a short last row', () {
      final r = calculateCompound(
        principal: 1000,
        annualRatePercent: 12,
        months: 18,
        type: PeriodType.yearly,
      );
      expect(r.rows.length, 2);
      expect(r.rows.last.label, '2 (6m)');
      expect(r.rows.last.interest, closeTo(1120 * 0.12 * 0.5, 1e-9));
    });
  });

  group('format', () {
    test('indian grouping', () {
      expect(formatMoney(1234567.5), '₹12,34,567.50');
      expect(formatMoney(999), '₹999.00');
      expect(formatNumber(100000), '1,00,000');
      expect(formatMoney(-1500), '-₹1,500.00');
    });
  });
}
