abstract class IMapConverter {
  Map<String, Object> toMap();
}

abstract class IMapLoader {
  Object fromMap(Map<String, Object> map);
}
