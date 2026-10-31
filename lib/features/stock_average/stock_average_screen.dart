import 'package:flutter/material.dart';

import '../../core/format.dart';
import '../../core/validators.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'stock_average_logic.dart';

class StockAverageScreen extends StatefulWidget {
  const StockAverageScreen({super.key});

  @override
  State<StockAverageScreen> createState() => _StockAverageScreenState();
}

class _StockAverageScreenState extends State<StockAverageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _price1 = TextEditingController();
  final _shares1 = TextEditingController();
  final _price2 = TextEditingController();
  final _shares2 = TextEditingController();

  bool _left1 = false;
  bool _left2 = false;
  StockAverageResult? _result;

  @override
  void dispose() {
    for (final c in [_price1, _shares1, _price2, _shares2]) {
      c.dispose();
    }
    super.dispose();
  }

  double? _amount(TextEditingController price, TextEditingController shares) {
    final p = parseNum(price.text);
    final s = parseNum(shares.text);
    if (p == null || s == null) return null;
    return p * s;
  }

  void _invalidate() {
    if (_result != null) setState(() => _result = null);
  }

  void _calculate() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _left1 = _left2 = true;
      _result = calculateAverage(
        price1: parseNum(_price1.text)!,
        shares1: parseNum(_shares1.text)!,
        price2: parseNum(_price2.text)!,
        shares2: parseNum(_shares2.text)!,
      );
    });
  }

  void _reset() {
    FocusScope.of(context).unfocus();
    for (final c in [_price1, _shares1, _price2, _shares2]) {
      c.clear();
    }
    _formKey.currentState?.reset();
    setState(() {
      _left1 = _left2 = false;
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final invested1 = _amount(_price1, _shares1);
    final invested2 = _amount(_price2, _shares2);
    final result = _result;

    return FeatureScaffold(
      title: 'Stock Average',
      accent: AppColors.blue,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              SectionCard(
                icon: Icons.history_rounded,
                title: 'Initial investment',
                subtitle: 'Your previous purchase',
                accent: AppColors.blue,
                softAccent: AppColors.blueSoft,
                children: [
                  NumberField(
                    controller: _price1,
                    label: 'Stock price',
                    prefix: '₹',
                    validator: positive,
                    onChanged: _invalidate,
                    onBlur: () => setState(() => _left1 = true),
                  ),
                  NumberField(
                    controller: _shares1,
                    label: 'No. of shares',
                    decimal: false,
                    validator: positive,
                    onChanged: _invalidate,
                    onBlur: () => setState(() => _left1 = true),
                  ),
                  if (_left1 && invested1 != null)
                    InfoChip(
                      label: 'Amount invested',
                      value: formatMoney(invested1),
                      background: AppColors.blueSoft,
                      foreground: AppColors.blueDark,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              SectionCard(
                icon: Icons.add_chart_rounded,
                title: 'New investment',
                subtitle: 'Planned purchase to average your price',
                accent: AppColors.green,
                softAccent: AppColors.greenSoft,
                children: [
                  NumberField(
                    controller: _price2,
                    label: 'Stock price',
                    prefix: '₹',
                    validator: positive,
                    onChanged: _invalidate,
                    onBlur: () => setState(() => _left2 = true),
                  ),
                  NumberField(
                    controller: _shares2,
                    label: 'No. of new shares',
                    decimal: false,
                    validator: positive,
                    onChanged: _invalidate,
                    onBlur: () => setState(() => _left2 = true),
                  ),
                  if (_left2 && invested2 != null)
                    InfoChip(
                      label: 'New amount',
                      value: formatMoney(invested2),
                      background: AppColors.greenSoft,
                      foreground: AppColors.green,
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
            label: 'New average price',
            value: formatMoney(result.averagePrice),
            background: AppColors.green,
            foreground: AppColors.white,
            icon: Icons.balance_rounded,
          ),
          const SizedBox(height: 12),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(
              children: [
                ReportRow(
                  label: 'Total shares (1 + 2)',
                  value: formatNumber(result.totalShares),
                ),
                const Divider(height: 1, color: AppColors.border),
                ReportRow(
                  label: 'Total investment (1 + 2)',
                  value: formatMoney(result.totalInvestment),
                ),
                const Divider(height: 1, color: AppColors.border),
                ReportRow(
                  label: 'Change vs. initial price',
                  value:
                      '${formatMoney(result.change)} (${result.changePercent.toStringAsFixed(2)}%)',
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
