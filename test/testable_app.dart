import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:tdd_intro/core/core.dart';
import 'package:tdd_intro/main.dart';

void multipleExpects(List<Function> expects) {
  var errorMessages = "";

  for (var f in expects) {
    try {
      f();
    } on TestFailure catch (e) {
      errorMessages += e.message;
    }
  }

  if (errorMessages.isNotEmpty) {
    fail(errorMessages);
  }
}

extension Tests on WidgetTester {
  List<T> widgetsByType<T extends Widget>() =>
      this.widgetList<T>(find.byType(T)).toList();

  T widgetByType<T extends Widget>() => this.widget<T>(find.byType(T));
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
