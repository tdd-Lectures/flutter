import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/vehicles/vehicles.dart';

class VehicleListWidget extends StatelessWidget {
  final List<Vehicle> vehicles;
  final Navigation navigation;

  const VehicleListWidget(
    this.vehicles,
    this.navigation,
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
