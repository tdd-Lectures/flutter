import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_intro/gateways/gateways.dart';
import 'package:tdd_intro/vehicles/vehicle.dart';
import 'package:tdd_intro/vehicles/vehicle_list_widget.dart';

import 'testable_app.dart';

class VehiclesQueryGatewayMock extends Mock implements VehiclesQueryGateway {}

void main() {
  group(VehiclePage, () {
    Future buildApp(WidgetTester tester) async {
      var query = VehiclesQueryGatewayMock();

      when(query.getVehicles()).thenAnswer((_) {
        return Future.value([
          Vehicle(),
        ]);
      });

      await tester.pumpWidget(
        TestableApp.makeApp(
          (locator) => VehiclePage(),
        ),
      );
    }

    testWidgets('on build show loading', (tester) async {
      await buildApp(tester);

      expect(find.text('loading...'), findsOneWidget);
    });

    testWidgets('display vehicle list after loading', (tester) async {
      await buildApp(tester);

      expect(find.byType(VehicleListWidget), findsOneWidget);
    });
  });
}

class VehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('loading...'),
    );
  }
}
