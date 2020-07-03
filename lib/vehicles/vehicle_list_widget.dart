import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/text_label.dart';
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
    return Container(
      color: Colors.white,
      child: Column(
        children: makeCards(),
      ),
    );
  }

  List<Widget> makeCards() {
    return (this.vehicles ?? []).map((vehicle) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: VehicleCardWidget(
          vehicle,
          navigation,
        ),
      );
    }).toList();
  }
}

class VehicleCardWidget extends StatelessWidget {
  final Vehicle vehicle;
  final Navigation navigation;

  const VehicleCardWidget(
    this.vehicle,
    this.navigation, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  TextLabel(vehicle.model ?? 'BMW'),
                ],
              ),
              Row(
                children: <Widget>[
                  if (vehicle.yearOfConstruction != null)
                    TextLabel(vehicle.yearOfConstruction.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    navigation.navigate<VehicleDetailWidget>(context);
  }
}
