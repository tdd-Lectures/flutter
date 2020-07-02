import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/text_label.dart';
import 'package:tdd_intro/vehicles/vehicles.dart';

import 'testable_app.dart';

void main() {
  group(VehicleListWidget, () {
    Future buildApp(WidgetTester tester, List<Vehicle> vehicles) async {
      await tester.pumpWidget(
        TestableApp.makeApp(
          (locator) => VehicleListWidget(
            vehicles,
            locator.resolve<Navigation>(),
          ),
        ),
      );
    }

    testWidgets('when vehicle is null dont display vehicle cards',
        (tester) async {
      await buildApp(tester, null);

      expect(find.byType(VehicleCardWidget), findsNothing);
    });

    testWidgets('when vehicle list is empty dont display vehicle cards',
        (tester) async {
      await buildApp(tester, []);

      expect(find.byType(VehicleCardWidget), findsNothing);
    });

    testWidgets('displays the vehicle information', (tester) async {
      var vehicles = [
        Vehicle(
          model: 'this is my model',
          yearOfConstruction: 2019,
        )
      ];

      await buildApp(tester, vehicles);

      assertDisplaysVehicle(
        model: 'this is my model',
        yearOfConstruction: 2019,
      );
      expect(find.byType(TextLabel), findsNWidgets(2));
    });

    testWidgets('when model is not provided display BMW', (tester) async {
      var vehicles = [
        Vehicle(
          model: null,
        )
      ];

      await buildApp(tester, vehicles);

      expect(find.text('BMW'), findsOneWidget);
    });

    testWidgets('when yearOfConstruction is not provided ignore field',
        (tester) async {
      var vehicles = [
        Vehicle(
          model: null,
          yearOfConstruction: null,
        )
      ];

      await buildApp(tester, vehicles);

      expect(find.byType(TextLabel), findsOneWidget);
    });

    testWidgets('displays multiple vehicles information', (tester) async {
      var vehicles = [
        Vehicle(
          model: 'this is another model',
          yearOfConstruction: 2017,
        ),
        Vehicle(
          model: 'this is yet another model',
          yearOfConstruction: 2013,
        )
      ];

      await buildApp(tester, vehicles);

      assertDisplaysVehicle(
        model: 'this is another model',
        yearOfConstruction: 2017,
      );
      assertDisplaysVehicle(
        model: 'this is yet another model',
        yearOfConstruction: 2013,
      );
    });

    testWidgets('displays a card per vehicle', (tester) async {
      var vehicles = [
        makeDummyVehicle(),
        makeDummyVehicle(),
      ];

      await buildApp(tester, vehicles);

      expect(find.byType(VehicleCardWidget), findsNWidgets(2));
    });

    testWidgets('tapping a card displays the vehicle details', (tester) async {
      var vehicles = [makeDummyVehicle()];

      await buildApp(tester, vehicles);

      await tester.tap(find.byType(VehicleCardWidget));
      await tester.pumpAndSettle();

      expect(find.byType(VehicleDetailWidget), findsOneWidget);
    });
  });
}

Vehicle makeDummyVehicle() {
  return Vehicle(
    model: '',
    yearOfConstruction: 2017,
  );
}

void assertDisplaysVehicle({String model, int yearOfConstruction}) {
  expect(find.text(model), findsOneWidget);
  expect(find.text(yearOfConstruction.toString()), findsOneWidget);
}
