import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'compound_interest/compound_interest_screen.dart';
import 'stock_average/stock_average_screen.dart';

class Feature {
  const Feature({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.softColor,
    required this.builder,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color softColor;
  final WidgetBuilder builder;
}

/// Every card on the home grid. Add a new entry here to add a feature.
final List<Feature> features = [
  Feature(
    id: 'stock_average',
    title: 'Stock Average',
    subtitle: 'Find your new average buy price',
    icon: Icons.candlestick_chart_rounded,
    color: AppColors.blue,
    softColor: AppColors.blueSoft,
    builder: (_) => const StockAverageScreen(),
  ),
  Feature(
    id: 'compound_interest',
    title: 'Compound Interest',
    subtitle: 'Watch your money grow period by period',
    icon: Icons.trending_up_rounded,
    color: AppColors.green,
    softColor: AppColors.greenSoft,
    builder: (_) => const CompoundInterestScreen(),
  ),
];
