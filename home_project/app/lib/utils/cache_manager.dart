import 'dart:async';
import 'dart:collection';

class CacheManager<T> {
  final _cache = LinkedHashMap<String, T>();
  final int maxSize;

  CacheManager({this.maxSize = 100});

  T? get(String key) {
    if (_cache.containsKey(key)) {
      // Move the item to the end of the map to mark it as recently used
      final value = _cache.remove(key);
      _cache[key] = value!;
      return value;
    }
    return null;
  }

  void set(String key, T value) {
    if (_cache.length == maxSize) {
      // Remove the least recently used item when at capacity
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = value;
  }

  void clear() {
    _cache.clear();
  }

  Future<void> prepopulate(Map<String, T> items) async {
    items.forEach((key, value) {
      set(key, value);
    });
  }
}