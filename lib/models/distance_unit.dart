class DistanceUnit {
  final String id;
  final String name;
  final String symbol;
  final double toMetersFactor; // factor to convert to meters

  const DistanceUnit({
    required this.id,
    required this.name,
    required this.symbol,
    required this.toMetersFactor,
  });

  String get displayName => '$name [$symbol]';

  static const List<DistanceUnit> allUnits = [
    DistanceUnit(
      id: 'm',
      name: 'meters',
      symbol: 'm',
      toMetersFactor: 1.0,
    ),
    DistanceUnit(
      id: 'km',
      name: 'kilometers',
      symbol: 'km',
      toMetersFactor: 1000.0,
    ),
    DistanceUnit(
      id: 'cm',
      name: 'centimeters',
      symbol: 'cm',
      toMetersFactor: 0.01,
    ),
    DistanceUnit(
      id: 'mm',
      name: 'millimeters',
      symbol: 'mm',
      toMetersFactor: 0.001,
    ),
    DistanceUnit(
      id: 'mi',
      name: 'miles',
      symbol: 'mi',
      toMetersFactor: 1609.344,
    ),
    DistanceUnit(
      id: 'yd',
      name: 'yards',
      symbol: 'yd',
      toMetersFactor: 0.9144,
    ),
    DistanceUnit(
      id: 'ft',
      name: 'feet',
      symbol: 'ft',
      toMetersFactor: 0.3048,
    ),
    DistanceUnit(
      id: 'nmi',
      name: 'nautical miles',
      symbol: 'nmi',
      toMetersFactor: 1852.0,
    ),
  ];

  static DistanceUnit defaultUnit = allUnits[0]; // meters
}
