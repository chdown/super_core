/// @author : ch
/// @date 2024-04-24 10:54:05
/// @description Map扩展类
///
extension ExtensionMap<K, V> on Map<K, V> {
  Map<K, V> where(bool Function(K k, V v) test) {
    Map<K, V> newMap = {};
    forEach((key, value) {
      if (test(key, value)) newMap[key] = value;
    });
    return newMap;
  }

  Map<K, V> addAllReturn(Map<K, V> newMap) {
    addAll(newMap);
    return this;
  }

  Map<K, V> copy() {
    Map<K, V> newMap = {};
    forEach((key, value) {
      newMap[key] = value;
    });
    return newMap;
  }
}
