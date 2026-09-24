import 'package:flutter_test/flutter_test.dart';
import 'package:speedshift/main.dart';

void main() {
  testWidgets('SpeedShift app basic load test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SpeedShiftApp());

    // Verify that app title and calculator tab are present
    expect(find.text('SpeedShift'), findsOneWidget);
    expect(find.text('Find Speed'), findsOneWidget);
  });
}
