import '../models/speed_unit.dart';
import '../models/distance_unit.dart';

class ConversionEngine {
  /// Converts speed value from [fromUnit] to [toUnit].
  /// Internal calculation converts [value] to base unit (m/s),
  /// then from base unit to [toUnit].
  static double convertSpeed(double value, SpeedUnit fromUnit, SpeedUnit toUnit) {
    if (fromUnit.id == toUnit.id) return value;
    // Step 1: Convert to base unit m/s
    final double inBaseMS = value * fromUnit.toBaseFactor;
    // Step 2: Convert from m/s to target unit
    final double result = inBaseMS / toUnit.toBaseFactor;
    return result;
  }

  /// Converts distance value from [fromUnit] to [toUnit].
  static double convertDistance(
      double value, DistanceUnit fromUnit, DistanceUnit toUnit) {
    if (fromUnit.id == toUnit.id) return value;
    final double inMeters = value * fromUnit.toMetersFactor;
    final double result = inMeters / toUnit.toMetersFactor;
    return result;
  }

  /// Formats a double value nicely without unnecessary trailing zeros.
  /// Example: 100.0 -> "100", 62.13711922 -> "62.137119" or "62.1371"
  static String formatNumber(double value, {int maxDecimals = 6}) {
    if (value.isNaN) return 'Error';
    if (value.isInfinite) return 'Infinity';

    // Check if integer
    if (value == value.roundToDouble() && value.abs() < 1e12) {
      return value.toInt().toString();
    }

    if (value.abs() >= 1e12 || (value.abs() < 1e-6 && value != 0)) {
      return value.toStringAsExponential(4);
    }

    String formatted = value.toStringAsFixed(maxDecimals);
    // Remove trailing zeros after decimal point
    if (formatted.contains('.')) {
      formatted = formatted.replaceAll(RegExp(r'0+$'), '');
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    }
    return formatted;
  }
}
