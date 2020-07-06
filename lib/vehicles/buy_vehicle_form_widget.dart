import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdd_intro/gateways/buy_vehicle_gateway.dart';
import 'package:tdd_intro/text_label.dart';

class BuyVehicleFormWidget extends StatelessWidget {
  final vehicleId = TextEditingController();
  final BuyVehicleGateway gateway;
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
          onPressed: () async {
            try {
              await _getGateway().buy(vehicleId.text);
            } catch (_) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Failed to Buy'),
                    content: TextLabel(
                        'At this time its not possible to buy this vehicle.'),
                  );
                },
              );
            }
          },
        )
      ],
    );
  }

  BuyVehicleGateway _getGateway() {
    if (vehicleId.text != '') return gateway;
    return _StubGateway();
  }
}

class _StubGateway implements BuyVehicleGateway {
  @override
  Future buy(String vehicleId) => null;
}
