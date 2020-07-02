import 'dart:convert';
import 'package:tdd_intro/core/core.dart';

class JsonDeserializer implements IDeserializer {
  const JsonDeserializer();

  @override
  TModel deserialize<TModel extends IMapLoader>(
      String data, ModelFactory<TModel> modelFactory) {
    if (_isInvalid(data, modelFactory)) return null;

    return modelFactory().fromMap(json.decode(data));
  }

  @override
  List<TModel> deserializeList<TModel extends IMapLoader>(
      String data, ModelFactory<TModel> modelFactory) {
    if (_isInvalid(data, modelFactory)) return List<TModel>();

    var mapped = json.decode(data);

    final casting = mapped.cast<Map<String, dynamic>>();

    return casting.map<TModel>((f) {
      return modelFactory().fromMap(f) as TModel;
    }).toList();
  }

  bool _isInvalid(String data, ModelFactory modelFactory) =>
      data == null || data.length == 0 || modelFactory == null;
}
