typedef Serializer<T> = T Function(Map<String, dynamic> map);

List<T> serializeList<T>(dynamic list, Serializer<T> serializer) {
  if (list == null) return [];
  return (list as List).map((dynamic e) => serializer(e)).toList();
}
