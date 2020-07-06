import 'package:tdd_intro/core/navigation.dart';
import 'package:tdd_intro/core/services.dart';

class CoreModule implements IServiceModule {
  @override
  void configure(ServiceRegistry registry) {
    registry.singleton<Navigation>((locator) => Navigation(locator));
  }
}
