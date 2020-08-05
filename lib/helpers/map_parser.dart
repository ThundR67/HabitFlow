/// Converts Iterabale<dynamic> came from map to List<T>.
List<T> list<T>(dynamic list) => List<T>.from(list as Iterable<dynamic>);

/// Converts Iterabale<dynamic> came from map to List<T>.
Map<String, T> dynamicToMap<T>(dynamic map) {
  return Map<String, T>.from(map as Map<String, dynamic>);
}
