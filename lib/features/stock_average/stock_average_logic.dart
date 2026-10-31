class StockAverageResult {
  const StockAverageResult({
    required this.totalShares,
    required this.totalInvestment,
    required this.averagePrice,
    required this.previousAverage,
  });

  final double totalShares;
  final double totalInvestment;
  final double averagePrice;
  final double previousAverage;

  /// Negative when the new purchase brought the average down.
  double get change => averagePrice - previousAverage;
  double get changePercent =>
      previousAverage == 0 ? 0 : change / previousAverage * 100;
}

StockAverageResult calculateAverage({
  required double price1,
  required double shares1,
  required double price2,
  required double shares2,
}) {
  final totalShares = shares1 + shares2;
  final totalInvestment = price1 * shares1 + price2 * shares2;
  return StockAverageResult(
    totalShares: totalShares,
    totalInvestment: totalInvestment,
    averagePrice: totalShares == 0 ? 0 : totalInvestment / totalShares,
    previousAverage: price1,
  );
}
