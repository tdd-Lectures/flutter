import 'package:flutter/widgets.dart';
import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/gateways/gateways.dart';

import 'vehicles.dart';

class VehiclePageWidget extends StatelessWidget {
  final VehiclesQueryGateway query;
  const VehiclePageWidget(this.query);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vehicle>>(
      future: query.getVehicles(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WidgetResolver<VehicleListWidget, List<Vehicle>>(
            snapshot.data,
          );
        }
        if (snapshot.hasError) {
          return Container();
        }

        return Container(
          child: Text('loading...'),
        );
      },
    );
  }
}
