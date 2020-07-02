import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String model;
  final String vehicleId;
  final int yearOfConstruction;
  final VehicleType type;

  Vehicle({
    this.model,
    this.vehicleId,
    this.yearOfConstruction,
    this.type,
  });

  @override
  List<Object> get props => [
        model,
        vehicleId,
        yearOfConstruction,
        type,
      ];

  @override
  bool get stringify => true;
}

enum VehicleType {
  S_Series,
  M_Series,
}
