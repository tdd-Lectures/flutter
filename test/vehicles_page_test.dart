import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_intro/gateways/gateways.dart';
import 'package:tdd_intro/vehicles/vehicle.dart';
import 'package:tdd_intro/vehicles/vehicle_list_widget.dart';
import 'package:tdd_intro/vehicles/vehicles.dart';

import 'testable_app.dart';
import 'vehicle_list_widget_test.dart';

class VehiclesQueryGatewayMock extends Mock implements VehiclesQueryGateway {}

void main() {
  group(VehiclePageWidget, () {
    Future buildApp(
      WidgetTester tester, {
      bool throwError = false,
      List<Vehicle> vehicles,
    }) async {
      await tester.pumpWidget(
        TestableApp.makeApp(
          (locator) => VehiclePageWidget(
            makeVehiclesQueryGateway(
              throwError,
              vehicles,
            ),
          ),
        ),
      );
    }

    testWidgets('on build show loading', (tester) async {
      await buildApp(tester);

      expect(find.text('loading...'), findsOneWidget);
    });

    testWidgets('display vehicle list after loading', (tester) async {
      await buildApp(tester, vehicles: [Vehicle()]);
      await tester.pumpAndSettle();

      expect(find.byType(VehicleListWidget), findsOneWidget);
      assertContainsNVehicles(1);
    });

    testWidgets("when vehicles get loaded doesn't show loading",
        (tester) async {
      await buildApp(tester, vehicles: [Vehicle()]);
      await tester.pumpAndSettle();

      expect(find.text('loading...'), findsNothing);
    });

    testWidgets("failing to get vehicles doesn't show the vehicle list",
        (tester) async {
      await buildApp(tester, throwError: true);
      await tester.pumpAndSettle();

      expect(find.byType(VehicleListWidget), findsNothing);
    });

    testWidgets('when query returns null vehicles list show loading',
        (tester) async {
      await buildApp(tester, vehicles: null);
      await tester.pumpAndSettle();

      expect(find.text('loading...'), findsOneWidget);
    });
  });
}

VehiclesQueryGatewayMock makeVehiclesQueryGateway(
  bool throwError,
  List<Vehicle> vehicles,
) {
  var query = VehiclesQueryGatewayMock();

  when(query.getVehicles()).thenAnswer((_) {
    if (throwError) {
      return Future.error(Error());
    }

    return Future.value(vehicles);
  });
  return query;
}
