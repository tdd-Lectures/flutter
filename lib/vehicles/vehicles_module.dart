import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/gateways/gateways.dart';
import 'package:tdd_intro/vehicles/vehicles.dart';

class VehiclesModule implements IServiceModule {
  @override
  void configure(ServiceRegistry registry) {
    registry.singleton(
      (locator) => VehicleListWidget(
        [
          Vehicle(),
        ],
        locator.resolve<Navigation>(),
      ),
    );

    registry.factory<VehicleListWidget, List<Vehicle>>((locator) {
      return Factory<VehicleListWidget, List<Vehicle>>(
        (data) {
          return VehicleListWidget(
            data,
            locator.resolve<Navigation>(),
          );
        },
      );
    });

    registry.singleton((_) => VehicleDetailWidget());

    registry.singleton(
      (locator) => VehiclePageWidget(
        locator.resolve<VehiclesQueryGateway>(),
      ),
    );

    registry.singleton<VehiclesQueryGateway>((_) => VehiclesQueryGatewayFake());
  }
}

class VehiclesQueryGatewayFake implements VehiclesQueryGateway {
  @override
  Future<List<Vehicle>> getVehicles() {
    return Future.value([
      Vehicle(
        model: '116d Sport',
        yearOfConstruction: 2000,
      ),
      Vehicle(
        model: '118d Sport',
        yearOfConstruction: 2016,
      ),
    ]);
  }
}
