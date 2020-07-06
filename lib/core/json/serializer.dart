import 'dart:convert';
import 'package:tdd_intro/core/core.dart';

class JsonSerializer implements ISerializer {
  const JsonSerializer();

  @override
  String getContentType() => "application/json";

  @override
  String serialize<TModel extends IMapConverter>(TModel object) {
    if (object == null) return json.encode('');

    return json.encode(object.toMap());
  }

  @override
  String serializeList<TModel extends IMapConverter>(List<TModel> object) {
    if (object == null || object.length == 0) return json.encode('');

    object.removeWhere((_) => _ == null);

    return json.encode(object.map((x) => x.toMap()).toList());
  }
}
