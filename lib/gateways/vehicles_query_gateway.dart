import 'package:tdd_intro/vehicles/vehicle.dart';

abstract class VehiclesQueryGateway {
  Future<List<Vehicle>> getVehicles();
}
