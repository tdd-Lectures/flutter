import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_intro/gateways/gateways.dart';
import 'package:tdd_intro/text_label.dart';
import 'package:tdd_intro/vehicles/vehicles.dart';

import 'testable_app.dart';

class BuyVehicleGatewayMock extends Mock implements BuyVehicleGateway {}

void main() {
  group(BuyVehicleFormWidget, () {
    BuyVehicleGateway gateway;

    void ensureVehicleWasBought(String vehicleId) {
      verify(gateway.buy(vehicleId));
    }

    Future buildApp(
      WidgetTester tester, {
      bool throwError = false,
      List<Vehicle> vehicles,
    }) async {
      gateway = BuyVehicleGatewayMock();

      await tester.pumpWidget(
        TestableApp.makeApp(
          (locator) => BuyVehicleFormWidget(gateway),
        ),
      );
    }

    testWidgets('displays text input', (tester) async {
      await buildApp(tester);

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('displays buy button', (tester) async {
      await buildApp(tester);

      var button = tester.widgetByType<RaisedButton>();
      expect(button, isNotNull);
      expect(button.child, isNotNull);
      expect(button.child as TextLabel, isNotNull);
      expect((button.child as TextLabel).text, 'buy');
    });

    testWidgets('on tapping buy button call buy gateway', (tester) async {
      await buildApp(tester);

      await tester.tap(find.byType(RaisedButton));

      ensureVehicleWasBought('');
    });

    testWidgets(
        'on tapping buy button call buy gateway with the input vehicle id',
        (tester) async {
      await buildApp(tester);

      await tester.enterText(find.byType(TextField), 'Vehicle1');
      await tester.tap(find.byType(RaisedButton));

      ensureVehicleWasBought('Vehicle1');
    });
  });
}
