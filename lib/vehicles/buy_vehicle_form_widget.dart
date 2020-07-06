import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdd_intro/gateways/buy_vehicle_gateway.dart';
import 'package:tdd_intro/text_label.dart';

class BuyVehicleFormWidget extends StatelessWidget {
  final vehicleId = TextEditingController();
  BuyVehicleGateway gateway;
  BuyVehicleFormWidget(this.gateway);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: vehicleId,
          ),
        ),
        RaisedButton(
          child: TextLabel('buy'),
          onPressed: () => gateway.buy(vehicleId.text),
        )
      ],
    );
  }
}
