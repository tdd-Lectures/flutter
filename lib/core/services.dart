import 'package:injector/injector.dart';

abstract class ILocator {
  T resolve<T>();

  T make<T, TArg>(TArg arg);
}

abstract class IServiceModule {
  void configure(ServiceRegistry registry);
}

typedef T ServiceBuilder<T>(ILocator registry);

abstract class ServiceRegistry extends ILocator {
  void singleton<T>(
    ServiceBuilder<T> builder, {
    bool override = false,
    String dependencyName = "",
  });

  T resolve<T>({String dependencyName = ""});

  void override<T>(ServiceBuilder<T> builder);

  void factory<TWidget, TArg>(
    ServiceBuilder<Factory<TWidget, TArg>> builder,
  );

  void register(List<IServiceModule> modules);
}

class InjectorRegistry implements ServiceRegistry {
  final Injector injector = Injector();

  InjectorRegistry();

  void singleton<T>(
    ServiceBuilder<T> builder, {
    bool override = false,
    String dependencyName = "",
  }) {
    injector.registerSingleton(
      (injector) => builder(this),
      override: override,
      dependencyName: dependencyName,
    );
  }

  T resolve<T>({String dependencyName = ""}) {
    return injector.getDependency<T>(dependencyName: dependencyName);
  }

  void override<T>(ServiceBuilder<T> builder) {
    singleton(builder, override: true);
  }

  void factory<T, TArg>(ServiceBuilder<Factory<T, TArg>> builder) {
    singleton<Factory<T, TArg>>(builder);
  }

  T make<T, TArg>(TArg arg) {
    var factory = resolve<Factory<T, TArg>>();
    return factory.make(arg);
  }

  void register(List<IServiceModule> modules) {
    modules.where((module) => module != null).forEach((module) {
      module.configure(this);
    });
  }
}

typedef T FactoryBuilder<T, TArg>(TArg registry);

class Factory<T, TArg> {
  final FactoryBuilder<T, TArg> builder;

  Factory(this.builder);

  T make(TArg arg) => builder(arg);
}
