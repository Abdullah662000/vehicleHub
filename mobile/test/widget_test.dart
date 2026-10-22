import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehiclehub_pakistan/app.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';

void main() {
  testWidgets('VehicleHubApp smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const VehicleHubApp(),
      ),
    );

    expect(find.byType(VehicleHubApp), findsOneWidget);

    // Let splash timer complete and settle navigation.
    await tester.pump(const Duration(milliseconds: 1900));
    await tester.pumpAndSettle();
  });
}
