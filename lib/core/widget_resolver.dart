import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tdd_intro/core/core.dart';

class WidgetResolverWithArgs<TWidget extends Widget, TArg>
    extends StatelessWidget {
  final TArg data;
  const WidgetResolverWithArgs(this.data);

  @override
  Widget build(BuildContext context) {
    return _getLocator(context).make<TWidget, TArg>(data);
  }

  ILocator _getLocator(BuildContext context) {
    return Provider.of<ILocator>(context, listen: false);
  }
}

class WidgetResolver<TWidget extends Widget> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _getLocator(context).resolve<TWidget>();
  }

  ILocator _getLocator(BuildContext context) {
    return Provider.of<ILocator>(context, listen: false);
  }
}
