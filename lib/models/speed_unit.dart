enum UnitCategory {
  common,
  other,
}

class SpeedUnit {
  final String id;
  final String name;
  final String symbol;
  final double toBaseFactor; // factor to multiply value in unit to get m/s
  final UnitCategory category;

  const SpeedUnit({
    required this.id,
    required this.name,
    required this.symbol,
    required this.toBaseFactor,
    required this.category,
  });

  String get displayName => '$name [$symbol]';

  // Base unit is meters/second [m/s]
  static const List<SpeedUnit> allUnits = [
    // COMMON SPEED UNITS
    SpeedUnit(
      id: 'm_s',
      name: 'meters/second',
      symbol: 'm/s',
      toBaseFactor: 1.0,
      category: UnitCategory.common,
    ),
    SpeedUnit(
      id: 'km_h',
      name: 'kilometers/hour',
      symbol: 'km/h',
      toBaseFactor: 1000.0 / 3600.0,
      category: UnitCategory.common,
    ),
    SpeedUnit(
      id: 'mph',
      name: 'miles/hour',
      symbol: 'mph',
      toBaseFactor: 1609.344 / 3600.0,
      category: UnitCategory.common,
    ),
    SpeedUnit(
      id: 'kn',
      name: 'knots',
      symbol: 'kn',
      toBaseFactor: 1852.0 / 3600.0,
      category: UnitCategory.common,
    ),
    SpeedUnit(
      id: 'ft_s',
      name: 'feet/second',
      symbol: 'ft/s',
      toBaseFactor: 0.3048,
      category: UnitCategory.common,
    ),

    // OTHER SPEED UNITS
    SpeedUnit(
      id: 'km_min',
      name: 'kilometers/minute',
      symbol: 'km/min',
      toBaseFactor: 1000.0 / 60.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'km_s',
      name: 'kilometers/second',
      symbol: 'km/s',
      toBaseFactor: 1000.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'm_h',
      name: 'meters/hour',
      symbol: 'm/h',
      toBaseFactor: 1.0 / 3600.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'm_min',
      name: 'meters/minute',
      symbol: 'm/min',
      toBaseFactor: 1.0 / 60.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'cm_h',
      name: 'centimeters/hour',
      symbol: 'cm/h',
      toBaseFactor: 0.01 / 3600.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'cm_min',
      name: 'centimeters/minute',
      symbol: 'cm/min',
      toBaseFactor: 0.01 / 60.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'cm_s',
      name: 'centimeters/second',
      symbol: 'cm/s',
      toBaseFactor: 0.01,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'mm_h',
      name: 'millimeters/hour',
      symbol: 'mm/h',
      toBaseFactor: 0.001 / 3600.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'mm_min',
      name: 'millimeters/minute',
      symbol: 'mm/min',
      toBaseFactor: 0.001 / 60.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'mm_s',
      name: 'millimeters/second',
      symbol: 'mm/s',
      toBaseFactor: 0.001,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'mi_min',
      name: 'miles/minute',
      symbol: 'mi/min',
      toBaseFactor: 1609.344 / 60.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'mi_s',
      name: 'miles/second',
      symbol: 'mi/s',
      toBaseFactor: 1609.344,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'yd_h',
      name: 'yards/hour',
      symbol: 'yd/h',
      toBaseFactor: 0.9144 / 3600.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'yd_min',
      name: 'yards/minute',
      symbol: 'yd/min',
      toBaseFactor: 0.9144 / 60.0,
      category: UnitCategory.other,
    ),
    SpeedUnit(
      id: 'yd_s',
      name: 'yards/second',
      symbol: 'yd/s',
      toBaseFactor: 0.9144,
      category: UnitCategory.other,
    ),
  ];

  static SpeedUnit defaultFrom = allUnits[1]; // km/h
  static SpeedUnit defaultTo = allUnits[2]; // mph
}
