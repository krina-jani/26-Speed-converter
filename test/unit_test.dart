import 'package:flutter_test/flutter_test.dart';
import 'package:speedshift/models/speed_unit.dart';
import 'package:speedshift/models/distance_unit.dart';
import 'package:speedshift/services/conversion_engine.dart';
import 'package:speedshift/services/speed_calculator_engine.dart';

void main() {
  group('Speed Conversion Tests (Section 40)', () {
    final unitMS = SpeedUnit.allUnits.firstWhere((u) => u.id == 'm_s');
    final unitKmH = SpeedUnit.allUnits.firstWhere((u) => u.id == 'km_h');
    final unitMph = SpeedUnit.allUnits.firstWhere((u) => u.id == 'mph');
    final unitKn = SpeedUnit.allUnits.firstWhere((u) => u.id == 'kn');
    final unitFtS = SpeedUnit.allUnits.firstWhere((u) => u.id == 'ft_s');

    test('1 m/s -> km/h equals 3.6', () {
      final res = ConversionEngine.convertSpeed(1.0, unitMS, unitKmH);
      expect(res, closeTo(3.6, 1e-6));
    });

    test('100 km/h -> mph equals approx 62.137119', () {
      final res = ConversionEngine.convertSpeed(100.0, unitKmH, unitMph);
      expect(res, closeTo(62.137119, 1e-4));
    });

    test('1 mph -> km/h equals 1.609344', () {
      final res = ConversionEngine.convertSpeed(1.0, unitMph, unitKmH);
      expect(res, closeTo(1.609344, 1e-6));
    });

    test('1 knot -> km/h equals 1.852', () {
      final res = ConversionEngine.convertSpeed(1.0, unitKn, unitKmH);
      expect(res, closeTo(1.852, 1e-6));
    });

    test('1 km/h -> m/s equals 0.277777...', () {
      final res = ConversionEngine.convertSpeed(1.0, unitKmH, unitMS);
      expect(res, closeTo(0.2777777, 1e-5));
    });

    test('1 ft/s -> m/s equals 0.3048', () {
      final res = ConversionEngine.convertSpeed(1.0, unitFtS, unitMS);
      expect(res, closeTo(0.3048, 1e-6));
    });
  });

  group('Speed Calculator Tests (Section 41)', () {
    final unitMS = SpeedUnit.allUnits.firstWhere((u) => u.id == 'm_s');
    final unitKmH = SpeedUnit.allUnits.firstWhere((u) => u.id == 'km_h');
    final unitM = DistanceUnit.allUnits.firstWhere((u) => u.id == 'm');
    final unitKm = DistanceUnit.allUnits.firstWhere((u) => u.id == 'km');

    test('Distance = 100 meters, Time = 20 seconds -> Speed = 5 m/s', () {
      final res = SpeedCalculatorEngine.calculateSpeed(
        distanceValue: 100,
        distanceUnit: unitM,
        hours: 0,
        minutes: 0,
        seconds: 20,
        outputSpeedUnit: unitMS,
      );
      expect(res, closeTo(5.0, 1e-6));
    });

    test('Distance = 1 kilometer, Time = 1 hour -> Speed = 1 km/h', () {
      final res = SpeedCalculatorEngine.calculateSpeed(
        distanceValue: 1,
        distanceUnit: unitKm,
        hours: 1,
        minutes: 0,
        seconds: 0,
        outputSpeedUnit: unitKmH,
      );
      expect(res, closeTo(1.0, 1e-6));
    });

    test('Speed = 60 km/h, Time = 2 hours -> Distance = 120 km', () {
      final res = SpeedCalculatorEngine.calculateDistance(
        speedValue: 60,
        speedUnit: unitKmH,
        hours: 2,
        minutes: 0,
        seconds: 0,
        outputDistanceUnit: unitKm,
      );
      expect(res, closeTo(120.0, 1e-6));
    });

    test('Distance = 120 km, Speed = 60 km/h -> Time = 2 hours', () {
      final res = SpeedCalculatorEngine.calculateTime(
        distanceValue: 120,
        distanceUnit: unitKm,
        speedValue: 60,
        speedUnit: unitKmH,
      );
      expect(res.hours, equals(2));
      expect(res.minutes, equals(0));
      expect(res.seconds, closeTo(0.0, 1e-6));
      expect(res.decimalHours, closeTo(2.0, 1e-6));
    });
  });
}
