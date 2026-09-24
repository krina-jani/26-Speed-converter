import '../models/speed_unit.dart';
import '../models/distance_unit.dart';
import 'conversion_engine.dart';

class TimeResult {
  final double totalSeconds;
  final int hours;
  final int minutes;
  final double seconds;
  final double decimalHours;
  final double decimalMinutes;

  TimeResult({
    required this.totalSeconds,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.decimalHours,
    required this.decimalMinutes,
  });

  String get formattedString {
    List<String> parts = [];
    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? "hour" : "hours"}');
    }
    if (minutes > 0 || hours > 0) {
      parts.add('$minutes ${minutes == 1 ? "minute" : "minutes"}');
    }
    String secFormatted = ConversionEngine.formatNumber(seconds, maxDecimals: 2);
    parts.add('$secFormatted ${seconds == 1 ? "second" : "seconds"}');
    return parts.join(' ');
  }
}

class SpeedCalculatorEngine {
  /// Find Speed: Speed = Distance / Time
  static double calculateSpeed({
    required double distanceValue,
    required DistanceUnit distanceUnit,
    required double hours,
    required double minutes,
    required double seconds,
    required SpeedUnit outputSpeedUnit,
  }) {
    final double totalSeconds = (hours * 3600.0) + (minutes * 60.0) + seconds;
    if (totalSeconds <= 0) {
      throw ArgumentError('Time must be greater than zero.');
    }
    final double distanceInMeters = distanceValue * distanceUnit.toMetersFactor;
    final double speedInMS = distanceInMeters / totalSeconds;
    // Convert m/s to output speed unit
    return speedInMS / outputSpeedUnit.toBaseFactor;
  }

  /// Find Distance: Distance = Speed * Time
  static double calculateDistance({
    required double speedValue,
    required SpeedUnit speedUnit,
    required double hours,
    required double minutes,
    required double seconds,
    required DistanceUnit outputDistanceUnit,
  }) {
    final double totalSeconds = (hours * 3600.0) + (minutes * 60.0) + seconds;
    if (totalSeconds < 0) {
      throw ArgumentError('Time cannot be negative.');
    }
    final double speedInMS = speedValue * speedUnit.toBaseFactor;
    final double distanceInMeters = speedInMS * totalSeconds;
    // Convert meters to output distance unit
    return distanceInMeters / outputDistanceUnit.toMetersFactor;
  }

  /// Find Time: Time = Distance / Speed
  static TimeResult calculateTime({
    required double distanceValue,
    required DistanceUnit distanceUnit,
    required double speedValue,
    required SpeedUnit speedUnit,
  }) {
    if (speedValue <= 0) {
      throw ArgumentError('Speed must be greater than zero.');
    }
    final double distanceInMeters = distanceValue * distanceUnit.toMetersFactor;
    final double speedInMS = speedValue * speedUnit.toBaseFactor;
    double totalSeconds = distanceInMeters / speedInMS;
    final double roundedSecs = totalSeconds.roundToDouble();
    if ((totalSeconds - roundedSecs).abs() < 1e-6) {
      totalSeconds = roundedSecs;
    }

    final int hrs = (totalSeconds / 3600.0).floor();
    final double remAfterHrs = totalSeconds - (hrs * 3600.0);
    final int mins = (remAfterHrs / 60.0).floor();
    final double secs = remAfterHrs - (mins * 60.0);

    final double decHrs = totalSeconds / 3600.0;
    final double decMins = totalSeconds / 60.0;

    return TimeResult(
      totalSeconds: totalSeconds,
      hours: hrs,
      minutes: mins,
      seconds: secs,
      decimalHours: decHrs,
      decimalMinutes: decMins,
    );
  }
}
