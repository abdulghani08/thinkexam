import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import 'base_datasource.dart';

/// Secure storage data source
/// Handles secure storage of sensitive data like tokens
class SecureStorageDataSource extends BaseDataSource {
  final FlutterSecureStorage _secureStorage;

  SecureStorageDataSource(this._secureStorage);

  /// Save a value to secure storage
  Future<void> save(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
      AppLogger.d('Saved to secure storage: $key');
    } catch (e) {
      AppLogger.e('Error saving to secure storage: $e');
      throw CacheException('Failed to save data securely');
    }
  }

  /// Read a value from secure storage
  Future<String?> read(String key) async {
    try {
      final value = await _secureStorage.read(key: key);
      AppLogger.d('Read from secure storage: $key');
      return value;
    } catch (e) {
      AppLogger.e('Error reading from secure storage: $e');
      throw CacheException('Failed to read data securely');
    }
  }

  /// Delete a value from secure storage
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
      AppLogger.d('Deleted from secure storage: $key');
    } catch (e) {
      AppLogger.e('Error deleting from secure storage: $e');
      throw CacheException('Failed to delete data securely');
    }
  }

  /// Clear all data from secure storage
  Future<void> clearAll() async {
    try {
      await _secureStorage.deleteAll();
      AppLogger.i('Cleared all secure storage');
    } catch (e) {
      AppLogger.e('Error clearing secure storage: $e');
      throw CacheException('Failed to clear secure storage');
    }
  }

  /// Check if a key exists in secure storage
  Future<bool> containsKey(String key) async {
    try {
      final contains = await _secureStorage.containsKey(key: key);
      return contains;
    } catch (e) {
      AppLogger.e('Error checking key in secure storage: $e');
      return false;
    }
  }
}
