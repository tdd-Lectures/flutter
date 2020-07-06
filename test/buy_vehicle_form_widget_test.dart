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
    String vehicleBought;

    BuyVehicleGatewayMock makeBuyVehicleGateway(
      bool throwError,
    ) {
      var gateway = BuyVehicleGatewayMock();

      when(gateway.buy(any)).thenAnswer((_) {
        if (throwError) {
          return Future.error(Error());
        }
        vehicleBought = _.positionalArguments[0];
        return Future.value(null);
      });

      return gateway;
    }

    void ensureVehicleWasBought(String vehicleId) {
      expect(vehicleBought, equals(vehicleId));
    }

    void ensureVehicleWasNotBought() {
      expect(vehicleBought, isNull);
    }

    Future buildApp(
      WidgetTester tester, {
      bool throwError = false,
    }) async {
      var gateway = makeBuyVehicleGateway(throwError);

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

    testWidgets("on tapping buy button without input doesn't call buy gateway",
        (tester) async {
      await buildApp(tester);

      await tester.tap(find.byType(RaisedButton));

      ensureVehicleWasNotBought();
    });

    testWidgets(
        'on tapping buy button call buy gateway with the input vehicle id',
        (tester) async {
      await buildApp(tester);

      await tester.enterText(find.byType(TextField), 'Vehicle1');
      await tester.tap(find.byType(RaisedButton));

      ensureVehicleWasBought('Vehicle1');
    });

    testWidgets('when buy fails popup dialog with error message',
        (tester) async {
      await buildApp(tester, throwError: true);

      await tester.enterText(find.byType(TextField), 'Vehicle1');
      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();

      assertAlertDialog(tester);
    });
  });
}

void assertAlertDialog(WidgetTester tester) {
  var dialog = tester.widgetByType<AlertDialog>();
  multipleExpects([
    () => expect(dialog, isNotNull),
    () => expect((dialog.title as Text), isNotNull, reason: 'title is not set'),
    () => expect((dialog.title as Text).data, 'Failed to Buy'),
    () => expect((dialog.content as TextLabel), isNotNull,
        reason: 'content is not set'),
    () => expect((dialog.content as TextLabel).text,
        'At this time its not possible to buy this vehicle.'),
  ]);
}
