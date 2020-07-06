import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdd_intro/core/services.dart';

class Navigation {
  final ILocator locator;
  const Navigation(this.locator);

  void navigate<TWidget extends Widget>(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => locator.resolve<TWidget>(),
      ),
    );
  }
}
