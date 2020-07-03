import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_intro/vehicles/vehicles.dart';

import 'testable_app.dart';

void main() {
  group(BuyVehicleFormWidget, () {
    Future buildApp(
      WidgetTester tester, {
      bool throwError = false,
      List<Vehicle> vehicles,
    }) async {
      await tester.pumpWidget(
        TestableApp.makeApp(
          (locator) => BuyVehicleFormWidget(),
        ),
      );
    }

    testWidgets('displays text input', (tester) async {
      await buildApp(tester);

      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
