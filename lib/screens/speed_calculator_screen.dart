import 'package:flutter/material.dart';
import '../models/speed_unit.dart';
import '../models/distance_unit.dart';
import '../services/conversion_engine.dart';
import '../services/speed_calculator_engine.dart';

class SpeedCalculatorScreen extends StatefulWidget {
  const SpeedCalculatorScreen({super.key});

  @override
  State<SpeedCalculatorScreen> createState() => _SpeedCalculatorScreenState();
}

class _SpeedCalculatorScreenState extends State<SpeedCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Find Speed Controllers & State
  final _speedDistController = TextEditingController(text: '100');
  DistanceUnit _speedDistUnit = DistanceUnit.defaultUnit; // meters
  final _speedHoursController = TextEditingController(text: '0');
  final _speedMinsController = TextEditingController(text: '0');
  final _speedSecsController = TextEditingController(text: '20');
  SpeedUnit _targetSpeedUnit = SpeedUnit.allUnits[0]; // m/s
  double? _calculatedSpeedResult;
  String? _speedError;

  // Find Distance Controllers & State
  final _distSpeedController = TextEditingController(text: '60');
  SpeedUnit _distSpeedUnit = SpeedUnit.allUnits[1]; // km/h
  final _distHoursController = TextEditingController(text: '2');
  final _distMinsController = TextEditingController(text: '0');
  final _distSecsController = TextEditingController(text: '0');
  DistanceUnit _targetDistUnit = DistanceUnit.allUnits[1]; // km
  double? _calculatedDistResult;
  String? _distError;

  // Find Time Controllers & State
  final _timeDistController = TextEditingController(text: '120');
  DistanceUnit _timeDistUnit = DistanceUnit.allUnits[1]; // km
  final _timeSpeedController = TextEditingController(text: '60');
  SpeedUnit _timeSpeedUnit = SpeedUnit.allUnits[1]; // km/h
  TimeResult? _calculatedTimeResult;
  String? _timeError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _speedDistController.dispose();
    _speedHoursController.dispose();
    _speedMinsController.dispose();
    _speedSecsController.dispose();

    _distSpeedController.dispose();
    _distHoursController.dispose();
    _distMinsController.dispose();
    _distSecsController.dispose();

    _timeDistController.dispose();
    _timeSpeedController.dispose();
    super.dispose();
  }

  void _calculateSpeed() {
    setState(() {
      _speedError = null;
      _calculatedSpeedResult = null;

      final distVal = double.tryParse(_speedDistController.text.trim());
      if (distVal == null || distVal < 0) {
        _speedError = 'Please enter a valid positive distance value.';
        return;
      }

      final hrs = double.tryParse(_speedHoursController.text.trim()) ?? 0;
      final mins = double.tryParse(_speedMinsController.text.trim()) ?? 0;
      final secs = double.tryParse(_speedSecsController.text.trim()) ?? 0;

      if (hrs < 0 || mins < 0 || secs < 0) {
        _speedError = 'Time values cannot be negative.';
        return;
      }

      if (hrs == 0 && mins == 0 && secs == 0) {
        _speedError = 'Total time must be greater than zero.';
        return;
      }

      try {
        _calculatedSpeedResult = SpeedCalculatorEngine.calculateSpeed(
          distanceValue: distVal,
          distanceUnit: _speedDistUnit,
          hours: hrs,
          minutes: mins,
          seconds: secs,
          outputSpeedUnit: _targetSpeedUnit,
        );
      } catch (e) {
        _speedError = e.toString().replaceAll('ArgumentError: ', '');
      }
    });
  }

  void _calculateDistance() {
    setState(() {
      _distError = null;
      _calculatedDistResult = null;

      final speedVal = double.tryParse(_distSpeedController.text.trim());
      if (speedVal == null || speedVal < 0) {
        _distError = 'Please enter a valid positive speed value.';
        return;
      }

      final hrs = double.tryParse(_distHoursController.text.trim()) ?? 0;
      final mins = double.tryParse(_distMinsController.text.trim()) ?? 0;
      final secs = double.tryParse(_distSecsController.text.trim()) ?? 0;

      if (hrs < 0 || mins < 0 || secs < 0) {
        _distError = 'Time values cannot be negative.';
        return;
      }

      if (hrs == 0 && mins == 0 && secs == 0) {
        _distError = 'Total time must be greater than zero.';
        return;
      }

      try {
        _calculatedDistResult = SpeedCalculatorEngine.calculateDistance(
          speedValue: speedVal,
          speedUnit: _distSpeedUnit,
          hours: hrs,
          minutes: mins,
          seconds: secs,
          outputDistanceUnit: _targetDistUnit,
        );
      } catch (e) {
        _distError = e.toString().replaceAll('ArgumentError: ', '');
      }
    });
  }

  void _calculateTime() {
    setState(() {
      _timeError = null;
      _calculatedTimeResult = null;

      final distVal = double.tryParse(_timeDistController.text.trim());
      if (distVal == null || distVal < 0) {
        _timeError = 'Please enter a valid positive distance value.';
        return;
      }

      final speedVal = double.tryParse(_timeSpeedController.text.trim());
      if (speedVal == null || speedVal <= 0) {
        _timeError = 'Please enter a valid speed value greater than zero.';
        return;
      }

      try {
        _calculatedTimeResult = SpeedCalculatorEngine.calculateTime(
          distanceValue: distVal,
          distanceUnit: _timeDistUnit,
          speedValue: speedVal,
          speedUnit: _timeSpeedUnit,
        );
      } catch (e) {
        _timeError = e.toString().replaceAll('ArgumentError: ', '');
      }
    });
  }

  void _clearCurrentTab() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _speedDistController.clear();
          _speedHoursController.text = '0';
          _speedMinsController.text = '0';
          _speedSecsController.text = '0';
          _calculatedSpeedResult = null;
          _speedError = null;
          break;
        case 1:
          _distSpeedController.clear();
          _distHoursController.text = '0';
          _distMinsController.text = '0';
          _distSecsController.text = '0';
          _calculatedDistResult = null;
          _distError = null;
          break;
        case 2:
          _timeDistController.clear();
          _timeSpeedController.clear();
          _calculatedTimeResult = null;
          _timeError = null;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Bar Container with Whole-Box Blue Color Segment Highlight
        Container(
          color: const Color(0xFF0F172A),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF334155), width: 1),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab, // Fills the entire segment box!
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF2563EB), // Solid blue block for selected segment
              ),
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF94A3B8),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: 'Find Speed'),
                Tab(text: 'Find Distance'),
                Tab(text: 'Find Time'),
              ],
            ),
          ),
        ),

        // Tab Views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildFindSpeedTab(),
              _buildFindDistanceTab(),
              _buildFindTimeTab(),
            ],
          ),
        ),
      ],
    );
  }

  // ================= FIND SPEED TAB =================
  Widget _buildFindSpeedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormHeader(
            title: 'Speed = Distance ÷ Time',
            subtitle: 'Calculate speed required to cover a distance in a set time.',
          ),
          const SizedBox(height: 20),

          // Labeled Input + Dropdown Row (Aligned perfectly on the same line)
          _buildInputWithUnitRow(
            label: 'Distance',
            controller: _speedDistController,
            hint: 'e.g. 100',
            unitDropdown: _buildDistanceDropdown(
              value: _speedDistUnit,
              onChanged: (val) {
                if (val != null) setState(() => _speedDistUnit = val);
              },
            ),
          ),
          const SizedBox(height: 16),

          // Time Duration Input Fields
          const Text(
            'Time Duration',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildTimeInput(
                  label: 'Hours',
                  controller: _speedHoursController,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeInput(
                  label: 'Mins',
                  controller: _speedMinsController,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeInput(
                  label: 'Secs',
                  controller: _speedSecsController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Desired Speed Unit
          const Text(
            'Desired Speed Unit',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: _buildSpeedDropdown(
              value: _targetSpeedUnit,
              onChanged: (val) {
                if (val != null) setState(() => _targetSpeedUnit = val);
              },
            ),
          ),

          if (_speedError != null) ...[
            const SizedBox(height: 10),
            Text(
              _speedError!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],

          const SizedBox(height: 24),
          _buildActionButtons(onCalculate: _calculateSpeed),

          if (_calculatedSpeedResult != null) ...[
            const SizedBox(height: 24),
            _buildResultCard(
              title: 'CALCULATED SPEED',
              mainText:
                  '${ConversionEngine.formatNumber(_calculatedSpeedResult!)} ${_targetSpeedUnit.symbol}',
              formula: 'Speed = Distance (${_speedDistController.text} ${_speedDistUnit.symbol}) ÷ Time',
            ),
          ],
        ],
      ),
    );
  }

  // ================= FIND DISTANCE TAB =================
  Widget _buildFindDistanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormHeader(
            title: 'Distance = Speed × Time',
            subtitle: 'Calculate total distance traveled at a given speed over time.',
          ),
          const SizedBox(height: 20),

          // Speed Input + Dropdown Row (Aligned on the same line)
          _buildInputWithUnitRow(
            label: 'Speed',
            controller: _distSpeedController,
            hint: 'e.g. 60',
            unitDropdown: _buildSpeedDropdown(
              value: _distSpeedUnit,
              onChanged: (val) {
                if (val != null) setState(() => _distSpeedUnit = val);
              },
            ),
          ),
          const SizedBox(height: 16),

          // Time Duration
          const Text(
            'Time Duration',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildTimeInput(
                  label: 'Hours',
                  controller: _distHoursController,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeInput(
                  label: 'Mins',
                  controller: _distMinsController,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeInput(
                  label: 'Secs',
                  controller: _distSecsController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Desired Distance Unit
          const Text(
            'Desired Distance Unit',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: _buildDistanceDropdown(
              value: _targetDistUnit,
              onChanged: (val) {
                if (val != null) setState(() => _targetDistUnit = val);
              },
            ),
          ),

          if (_distError != null) ...[
            const SizedBox(height: 10),
            Text(
              _distError!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],

          const SizedBox(height: 24),
          _buildActionButtons(onCalculate: _calculateDistance),

          if (_calculatedDistResult != null) ...[
            const SizedBox(height: 24),
            _buildResultCard(
              title: 'CALCULATED DISTANCE',
              mainText:
                  '${ConversionEngine.formatNumber(_calculatedDistResult!)} ${_targetDistUnit.symbol}',
              formula: 'Distance = Speed (${_distSpeedController.text} ${_distSpeedUnit.symbol}) × Time',
            ),
          ],
        ],
      ),
    );
  }

  // ================= FIND TIME TAB =================
  Widget _buildFindTimeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormHeader(
            title: 'Time = Distance ÷ Speed',
            subtitle: 'Calculate total duration to travel a distance at a given speed.',
          ),
          const SizedBox(height: 20),

          // Distance Field Row
          _buildInputWithUnitRow(
            label: 'Distance',
            controller: _timeDistController,
            hint: 'e.g. 120',
            unitDropdown: _buildDistanceDropdown(
              value: _timeDistUnit,
              onChanged: (val) {
                if (val != null) setState(() => _timeDistUnit = val);
              },
            ),
          ),
          const SizedBox(height: 16),

          // Speed Field Row
          _buildInputWithUnitRow(
            label: 'Speed',
            controller: _timeSpeedController,
            hint: 'e.g. 60',
            unitDropdown: _buildSpeedDropdown(
              value: _timeSpeedUnit,
              onChanged: (val) {
                if (val != null) setState(() => _timeSpeedUnit = val);
              },
            ),
          ),

          if (_timeError != null) ...[
            const SizedBox(height: 10),
            Text(
              _timeError!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],

          const SizedBox(height: 24),
          _buildActionButtons(onCalculate: _calculateTime),

          if (_calculatedTimeResult != null) ...[
            const SizedBox(height: 24),
            _buildResultCard(
              title: 'CALCULATED TIME',
              mainText: _calculatedTimeResult!.formattedString,
              formula:
                  'Time = Distance (${_timeDistController.text} ${_timeDistUnit.symbol}) ÷ Speed (${_timeSpeedController.text} ${_timeSpeedUnit.symbol})\n'
                  'Decimal: ${ConversionEngine.formatNumber(_calculatedTimeResult!.decimalHours, maxDecimals: 4)} hours (${ConversionEngine.formatNumber(_calculatedTimeResult!.decimalMinutes, maxDecimals: 2)} mins)',
            ),
          ],
        ],
      ),
    );
  }

  // ================= REUSABLE UI BUILDERS =================
  Widget _buildFormHeader({required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  /// Unified Labeled Row for Input Field & Unit Dropdown in the Exact Same Horizontal Line
  Widget _buildInputWithUnitRow({
    required String label,
    required TextEditingController controller,
    required String hint,
    required Widget unitDropdown,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 48,
                child: unitDropdown,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeInput({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedDropdown({
    required SpeedUnit value,
    required ValueChanged<SpeedUnit?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
          items: SpeedUnit.allUnits.map((unit) {
            return DropdownMenuItem<SpeedUnit>(
              value: unit,
              child: Text(
                unit.displayName,
                style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDistanceDropdown({
    required DistanceUnit value,
    required ValueChanged<DistanceUnit?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DistanceUnit>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF475569)),
          onChanged: onChanged,
          items: DistanceUnit.allUnits.map((unit) {
            return DropdownMenuItem<DistanceUnit>(
              value: unit,
              child: Text(
                unit.displayName,
                style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildActionButtons({required VoidCallback onCalculate}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: onCalculate,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981), // Prominent green action button
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
            icon: const Icon(Icons.play_arrow_rounded, size: 22),
            label: const Text(
              'Calculate',
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
            onPressed: _clearCurrentTab,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF475569),
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.clear_all_rounded, size: 18),
            label: const Text(
              'Clear',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard({
    required String title,
    required String mainText,
    required String formula,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF38BDF8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const Icon(Icons.check_circle_outline, color: Color(0xFF10B981), size: 18),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            mainText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFF334155)),
          const SizedBox(height: 6),
          Text(
            'Formula: $formula',
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
