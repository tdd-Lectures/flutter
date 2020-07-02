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

    registry.singleton((_) => VehicleDetailWidget());
  }
}
