import 'package:tdd_intro/core/map_converters.dart';

typedef ModelFactory<T> = T Function();

abstract class ISerializer {
  String getContentType();
  String serialize<TModel extends IMapConverter>(TModel object);
  String serializeList<TModel extends IMapConverter>(List<TModel> object);
}

abstract class IDeserializer {
  TModel deserialize<TModel extends IMapLoader>(
      String data, ModelFactory<TModel> modelFactory);

  List<TModel> deserializeList<TModel extends IMapLoader>(
      String data, ModelFactory<TModel> modelFactory);
}
