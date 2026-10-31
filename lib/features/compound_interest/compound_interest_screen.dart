import 'package:flutter/material.dart';

import '../../core/format.dart';
import '../../core/validators.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../widgets/paged_table.dart';
import 'compound_interest_logic.dart';

class CompoundInterestScreen extends StatefulWidget {
  const CompoundInterestScreen({super.key});

  @override
  State<CompoundInterestScreen> createState() => _CompoundInterestScreenState();
}

class _CompoundInterestScreenState extends State<CompoundInterestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _principal = TextEditingController();
  final _rate = TextEditingController();
  final _months = TextEditingController();

  PeriodType _type = PeriodType.monthly;
  CompoundResult? _result;

  @override
  void dispose() {
    for (final c in [_principal, _rate, _months]) {
      c.dispose();
    }
    super.dispose();
  }

  void _invalidate() {
    if (_result != null) setState(() => _result = null);
  }

  void _calculate() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _result = calculateCompound(
        principal: parseNum(_principal.text)!,
        annualRatePercent: parseNum(_rate.text)!,
        months: parseNum(_months.text)!.toInt(),
        type: _type,
      );
    });
  }

  void _reset() {
    FocusScope.of(context).unfocus();
    for (final c in [_principal, _rate, _months]) {
      c.clear();
    }
    _formKey.currentState?.reset();
    setState(() {
      _type = PeriodType.monthly;
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;

    return FeatureScaffold(
      title: 'Compound Interest',
      accent: AppColors.green,
      children: [
        Form(
          key: _formKey,
          child: SectionCard(
            icon: Icons.savings_rounded,
            title: 'Your investment',
            subtitle: 'Interest is added to the principal every period',
            accent: AppColors.green,
            softAccent: AppColors.greenSoft,
            children: [
              NumberField(
                controller: _principal,
                label: 'Principal',
                prefix: '₹',
                validator: positive,
                onChanged: _invalidate,
              ),
              NumberField(
                controller: _rate,
                label: 'Rate (annual)',
                suffix: '% per year',
                validator: nonNegative,
                onChanged: _invalidate,
              ),
              NumberField(
                controller: _months,
                label: 'Duration',
                suffix: 'months',
                decimal: false,
                validator: wholeBetween(1, 1200),
                onChanged: _invalidate,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Compounding period',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<PeriodType>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(
                          value: PeriodType.monthly,
                          label: Text('Monthly'),
                        ),
                        ButtonSegment(
                          value: PeriodType.yearly,
                          label: Text('Yearly'),
                        ),
                      ],
                      selected: {_type},
                      onSelectionChanged: (s) => setState(() {
                        _type = s.first;
                        _result = null;
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ActionButtons(onCalculate: _calculate, onReset: _reset),
        if (result != null) ...[
          const SizedBox(height: 24),
          const ReportHeader(),
          const SizedBox(height: 12),
          HighlightTile(
            label: 'Total interest earned',
            value: formatMoney(result.totalInterest),
            background: AppColors.green,
            foreground: AppColors.white,
            icon: Icons.paid_rounded,
          ),
          const SizedBox(height: 12),
          HighlightTile(
            label: 'Final amount',
            value: formatMoney(result.finalAmount),
            background: AppColors.yellow,
            foreground: AppColors.ink,
            icon: Icons.account_balance_wallet_rounded,
          ),
          const SizedBox(height: 24),
          ReportHeader(
            title: _type == PeriodType.monthly
                ? 'Month-by-month'
                : 'Year-by-year',
          ),
          const SizedBox(height: 12),
          PagedTable(
            key: ObjectKey(result),
            headers: [
              _type == PeriodType.monthly ? 'Month' : 'Year',
              'Principal',
              'Interest',
              'Amount',
            ],
            rows: [
              for (final r in result.rows)
                [
                  r.label,
                  formatMoney(r.principal),
                  formatMoney(r.interest),
                  formatMoney(r.amount),
                ],
            ],
          ),
        ],
      ],
    );
  }
}
