import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/main.dart';

extension Tests on WidgetTester {
  List<T> widgetsByType<T extends Widget>() =>
      this.widgetList(find.byType(T)).cast<T>().toList();
}

Type typeOf<T>() => T;

class TestableApp {
  static Widget makeApp(
    Widget Function(ILocator) widget, {
    void Function(Injector injector) injection,
    IServiceModule module,
  }) {
    return OurCoolApp(
      home: (factory) => widget(factory),
      testModules: [module],
    );
  }
}
