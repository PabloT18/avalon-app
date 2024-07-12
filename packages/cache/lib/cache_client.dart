import 'dart:convert';
import 'dart:ffi';

import 'package:hive/hive.dart';

import 'constant_keys_cahce.dart';

class CacheClient {
  /// {@macro cache_client}
  // CacheClient() : _cache = <String, Object>{};

  // final Map<String, Object> _cache;

  // /// Writes the provide [key], [value] pair to the in-memory cache.
  // void write<T extends Object>({required String key, required T value}) {
  //   _cache[key] = value;
  // }

  // /// Looks up the value for the provided [key].
  // /// Defaults to `null` if no value exists for the provided key.
  // T? read<T extends Object>({required String key}) {
  //   final value = _cache[key];
  //   if (value is T) return value;
  //   return null;
  // }
  CacheClient() : _box = Hive.box(ConstHiveBox.kHiveBoxName);
  final Box _box;

  /// Writes the provided [value] with [key] to the box.
  Future<void> write<T extends Object>(
      {required String key, required T value}) async {
    if (value is Map<String, dynamic>) {
      await _box.put(key, value);
    } else {
      // Serializar objetos que no sean Map directamente a JSON
      String jsonString = json.encode(value);
      await _box.put(key, jsonString);
    }
  }

  /// Reads the value for the provided [key].
  dynamic read({required String key}) {
    return _box.get(key);
  }

  /// Clears all data stored in the box.
  Future<void> clear() async {
    await _box.clear();
  }
}
