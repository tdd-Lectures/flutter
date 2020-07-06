import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/core/core_module.dart';
import 'package:tdd_intro/vehicles/vehicles.dart';

void main() => runApp(OurCoolApp());

var registeredModules = [
  CoreModule(),
  VehiclesModule(),
];

class OurCoolApp extends StatefulWidget {
  final List<IServiceModule> testModules;
  final Widget Function(ILocator) home;

  OurCoolApp({
    this.testModules,
    this.home = _buildHome,
  });

  static Widget _buildHome(ILocator locator) =>
      locator.resolve<VehicleListWidget>();

  @override
  _OurCoolAppState createState() => _OurCoolAppState();
}

class _OurCoolAppState extends State<OurCoolApp> {
  ILocator locator;

  void _init({List<IServiceModule> testModules}) {
    var services = InjectorRegistry();

    services.register(registeredModules);

    // Override services for mock purposes.
    if (testModules != null) {
      services.register(testModules);
    }

    locator = services;
  }

  @override
  void initState() {
    _init(testModules: widget.testModules);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ILocator>(
      create: (_) => locator,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: widget.home(locator),
        ),
      ),
    );
  }
}
