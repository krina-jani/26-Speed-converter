import 'package:flutter/material.dart';
import 'speed_calculator_screen.dart';
import 'speed_converter_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    SpeedCalculatorScreen(),
    SpeedConverterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Clean light slate background
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A), // Dark navy header
        elevation: 2,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF1E293B),
                border: Border.all(
                  color: const Color(0xFF38BDF8).withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/icons/speedshift_logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.speed_rounded, color: Color(0xFF38BDF8), size: 24),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'SpeedShift',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          // Information Icon button for About screen
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 24),
            tooltip: 'About SpeedShift',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F172A),
          border: Border(
            top: BorderSide(color: Color(0xFF1E293B), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 2) {
              // Tap on (i) info icon directly opens About screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            } else {
              setState(() => _currentIndex = index);
            }
          },
          backgroundColor: const Color(0xFF0F172A),
          selectedItemColor: const Color(0xFF38BDF8),
          unselectedItemColor: const Color(0xFF94A3B8),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarViewItem(
              icon: Icon(Icons.calculate_outlined),
              activeIcon: Icon(Icons.calculate),
              label: 'Calculator',
            ),
            BottomNavigationBarViewItem(
              icon: Icon(Icons.swap_calls_outlined),
              activeIcon: Icon(Icons.swap_calls),
              label: 'Converter',
            ),
            BottomNavigationBarViewItem(
              icon: Icon(Icons.info_outline_rounded, size: 24),
              activeIcon: Icon(Icons.info_rounded, size: 24),
              label: '', // ONLY (i) icon, no text label as requested
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationBarViewItem extends BottomNavigationBarItem {
  const BottomNavigationBarViewItem({
    required super.icon,
    super.activeIcon,
    required super.label,
  });
}
