import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for storage service (will be overridden in main.dart)
final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('Storage service must be overridden');
});

/// Service that handles local storage using SharedPreferences
class StorageService {
  const StorageService(this._prefs);

  final SharedPreferences _prefs;

  /// Save string value
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// Get string value
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Save int value
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Get int value
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Save double value
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  /// Get double value
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  /// Save bool value
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Get bool value
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Save string list
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// Get string list
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  /// Save object as JSON
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    return await _prefs.setString(key, jsonString);
  }

  /// Get object from JSON
  Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Save list of objects as JSON
  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) async {
    final jsonString = jsonEncode(value);
    return await _prefs.setString(key, jsonString);
  }

  /// Get list of objects from JSON
  List<Map<String, dynamic>>? getJsonList(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  /// Remove a specific key
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Clear all data
  Future<bool> clear() async {
    return await _prefs.clear();
  }

  /// Get all keys
  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  /// Reload shared preferences
  Future<void> reload() async {
    await _prefs.reload();
  }
}

/// Extension methods for easier access
extension StorageServiceExtensions on StorageService {
  /// Save DateTime
  Future<bool> setDateTime(String key, DateTime value) async {
    return await setString(key, value.toIso8601String());
  }

  /// Get DateTime
  DateTime? getDateTime(String key) {
    final dateString = getString(key);
    if (dateString == null) return null;
    
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Save Duration
  Future<bool> setDuration(String key, Duration value) async {
    return await setInt(key, value.inMilliseconds);
  }

  /// Get Duration
  Duration? getDuration(String key) {
    final milliseconds = getInt(key);
    if (milliseconds == null) return null;
    
    return Duration(milliseconds: milliseconds);
  }

  /// Save enum value
  Future<bool> setEnum<T extends Enum>(String key, T value) async {
    return await setString(key, value.name);
  }

  /// Get enum value
  T? getEnum<T extends Enum>(String key, List<T> values) {
    final name = getString(key);
    if (name == null) return null;
    
    try {
      return values.firstWhere((e) => e.name == name);
    } catch (e) {
      return null;
    }
  }
}

/// Cache manager for temporary data with expiration
class CacheManager {
  CacheManager(this._storage);

  final StorageService _storage;
  
  static const String _cachePrefix = 'cache_';
  static const String _expirationSuffix = '_exp';

  /// Save data to cache with expiration
  Future<bool> setCache({
    required String key,
    required dynamic value,
    Duration? expiration,
  }) async {
    final cacheKey = '$_cachePrefix$key';
    
    // Save the value
    bool saved = false;
    if (value is String) {
      saved = await _storage.setString(cacheKey, value);
    } else if (value is int) {
      saved = await _storage.setInt(cacheKey, value);
    } else if (value is double) {
      saved = await _storage.setDouble(cacheKey, value);
    } else if (value is bool) {
      saved = await _storage.setBool(cacheKey, value);
    } else if (value is List<String>) {
      saved = await _storage.setStringList(cacheKey, value);
    } else if (value is Map<String, dynamic>) {
      saved = await _storage.setJson(cacheKey, value);
    } else if (value is List<Map<String, dynamic>>) {
      saved = await _storage.setJsonList(cacheKey, value);
    }
    
    // Save expiration time if provided
    if (saved && expiration != null) {
      final expirationTime = DateTime.now().add(expiration);
      await _storage.setDateTime('$cacheKey$_expirationSuffix', expirationTime);
    }
    
    return saved;
  }

  /// Get data from cache
  T? getCache<T>(String key) {
    final cacheKey = '$_cachePrefix$key';
    
    // Check if expired
    final expirationTime = _storage.getDateTime('$cacheKey$_expirationSuffix');
    if (expirationTime != null && DateTime.now().isAfter(expirationTime)) {
      // Remove expired data
      removeCache(key);
      return null;
    }
    
    // Return the cached value
    if (T == String) {
      return _storage.getString(cacheKey) as T?;
    } else if (T == int) {
      return _storage.getInt(cacheKey) as T?;
    } else if (T == double) {
      return _storage.getDouble(cacheKey) as T?;
    } else if (T == bool) {
      return _storage.getBool(cacheKey) as T?;
    } else if (T == List<String>) {
      return _storage.getStringList(cacheKey) as T?;
    } else if (T == Map<String, dynamic>) {
      return _storage.getJson(cacheKey) as T?;
    } else if (T == List<Map<String, dynamic>>) {
      return _storage.getJsonList(cacheKey) as T?;
    }
    
    return null;
  }

  /// Remove cached data
  Future<void> removeCache(String key) async {
    final cacheKey = '$_cachePrefix$key';
    await _storage.remove(cacheKey);
    await _storage.remove('$cacheKey$_expirationSuffix');
  }

  /// Clear all cache
  Future<void> clearCache() async {
    final keys = _storage.getKeys();
    for (final key in keys) {
      if (key.startsWith(_cachePrefix)) {
        await _storage.remove(key);
      }
    }
  }

  /// Check if cache exists and is not expired
  bool hasCache(String key) {
    final cacheKey = '$_cachePrefix$key';
    
    if (!_storage.containsKey(cacheKey)) {
      return false;
    }
    
    final expirationTime = _storage.getDateTime('$cacheKey$_expirationSuffix');
    if (expirationTime != null && DateTime.now().isAfter(expirationTime)) {
      return false;
    }
    
    return true;
  }
}