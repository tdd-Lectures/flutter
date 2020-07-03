import 'package:tdd_intro/core/core.dart';
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
  }
}
