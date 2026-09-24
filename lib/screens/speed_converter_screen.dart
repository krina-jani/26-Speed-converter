import 'package:flutter/material.dart';
import '../models/speed_unit.dart';
import '../services/conversion_engine.dart';

class SpeedConverterScreen extends StatefulWidget {
  const SpeedConverterScreen({super.key});

  @override
  State<SpeedConverterScreen> createState() => _SpeedConverterScreenState();
}

class _SpeedConverterScreenState extends State<SpeedConverterScreen> {
  final TextEditingController _inputController = TextEditingController(text: '100');
  SpeedUnit _fromUnit = SpeedUnit.defaultFrom; // km/h
  SpeedUnit _toUnit = SpeedUnit.defaultTo;     // mph

  String? _errorMessage;
  double? _resultValue;

  @override
  void initState() {
    super.initState();
    _performConversion();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _performConversion() {
    setState(() {
      _errorMessage = null;
      final text = _inputController.text.trim();
      if (text.isEmpty) {
        _resultValue = null;
        return;
      }

      final parsed = double.tryParse(text);
      if (parsed == null) {
        _errorMessage = 'Please enter a valid numeric speed value.';
        _resultValue = null;
        return;
      }

      if (parsed < 0) {
        _errorMessage = 'Please enter a valid positive speed value.';
        _resultValue = null;
        return;
      }

      _resultValue = ConversionEngine.convertSpeed(parsed, _fromUnit, _toUnit);
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
    _performConversion();
  }

  void _clear() {
    setState(() {
      _inputController.clear();
      _resultValue = null;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Card / Instruction
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // Light slate
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Row(
              children: [
                Icon(Icons.swap_calls_rounded, color: Color(0xFF0F172A), size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Convert speed values across 20+ precise units instantly.',
                    style: TextStyle(
                      color: Color(0xFF334155),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Speed Value Input Field
          const Text(
            'Speed Value',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _inputController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: 'Enter speed (e.g. 100)',
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
              ),
              suffixIcon: _inputController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _inputController.clear();
                        _performConversion();
                      },
                    )
                  : null,
            ),
            onChanged: (_) => _performConversion(),
          ),

          if (_errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],

          const SizedBox(height: 20),

          // From & To Units Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // From Unit Dropdown
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'From Unit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildUnitDropdown(
                      value: _fromUnit,
                      onChanged: (newUnit) {
                        if (newUnit != null) {
                          setState(() => _fromUnit = newUnit);
                          _performConversion();
                        }
                      },
                    ),
                  ],
                ),
              ),

              // Swap Button
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
                child: InkWell(
                  onTap: _swapUnits,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.swap_horiz_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // To Unit Dropdown
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'To Unit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildUnitDropdown(
                      value: _toUnit,
                      onChanged: (newUnit) {
                        if (newUnit != null) {
                          setState(() => _toUnit = newUnit);
                          _performConversion();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Action Buttons: Calculate / Clear
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _performConversion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981), // Green action button
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.calculate_outlined, size: 20),
                  label: const Text(
                    'Convert',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: OutlinedButton.icon(
                  onPressed: _clear,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF475569),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Result Card
          if (_resultValue != null) _buildResultCard(),
        ],
      ),
    );
  }

  Widget _buildUnitDropdown({
    required SpeedUnit value,
    required ValueChanged<SpeedUnit?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SpeedUnit>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF475569)),
          onChanged: onChanged,
          items: _buildGroupedDropdownItems(),
        ),
      ),
    );
  }

  List<DropdownMenuItem<SpeedUnit>> _buildGroupedDropdownItems() {
    final List<DropdownMenuItem<SpeedUnit>> items = [];

    // Header: Common Speed Units
    items.add(
      const DropdownMenuItem<SpeedUnit>(
        enabled: false,
        child: Text(
          '—— COMMON SPEED UNITS ——',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2563EB),
          ),
        ),
      ),
    );

    for (var unit in SpeedUnit.allUnits.where((u) => u.category == UnitCategory.common)) {
      items.add(
        DropdownMenuItem<SpeedUnit>(
          value: unit,
          child: Text(
            unit.displayName,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    // Header: Other Speed Units
    items.add(
      const DropdownMenuItem<SpeedUnit>(
        enabled: false,
        child: Text(
          '—— OTHER SPEED UNITS ——',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF64748B),
          ),
        ),
      ),
    );

    for (var unit in SpeedUnit.allUnits.where((u) => u.category == UnitCategory.other)) {
      items.add(
        DropdownMenuItem<SpeedUnit>(
          value: unit,
          child: Text(
            unit.displayName,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return items;
  }

  Widget _buildResultCard() {
    final double inputVal = double.tryParse(_inputController.text) ?? 0;
    final String formattedInput = ConversionEngine.formatNumber(inputVal);
    final String formattedResult = ConversionEngine.formatNumber(_resultValue!);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Dark navy card
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CONVERTED RESULT',
                style: TextStyle(
                  color: Color(0xFF38BDF8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              Icon(Icons.check_circle_outline, color: Color(0xFF10B981), size: 18),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$formattedResult ${_toUnit.symbol}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFF334155)),
          const SizedBox(height: 8),
          Text(
            'Calculation: $formattedInput ${_fromUnit.displayName} = $formattedResult ${_toUnit.displayName}',
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
