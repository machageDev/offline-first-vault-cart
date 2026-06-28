import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService()
      : _secureStorage = const FlutterSecureStorage(
          
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );

  static const String _hiveKeyIdentifier = 'krypt_cart_master_key';

 
  Future<List<int>> getOrCreateHiveEncryptionKey() async {
    try {
      final containsKey = await _secureStorage.containsKey(key: _hiveKeyIdentifier);

      if (!containsKey) {
        // Generates a cryptographically strong 256-bit random key natively via Hive
        final newSecureKey = Hive.generateSecureKey();
        
        // Encode binary key to a URL-safe Base64 string for text storage
        final encodedKey = base64Url.encode(newSecureKey);
        
        await _secureStorage.write(key: _hiveKeyIdentifier, value: encodedKey);
        return newSecureKey;
      }

      // Read string key back out of hardware-locked system storage
      final base64Key = await _secureStorage.read(key: _hiveKeyIdentifier);
      if (base64Key == null) {
        throw Exception("Secure Key corrupted or missing in vault");
      }

      // Re-convert back to a raw binary byte list required by Hive's AES engine
      return base64Url.decode(base64Key);
    } catch (e) {
      // Gracefully prevent unhandled system crashes by wrapping into a known error signature
      throw Exception("Vault Read/Write Failure: Secure Storage subsystem unreachable.");
    }
  }

  
  Future<void> purgeSecureKey() async {
    await _secureStorage.delete(key: _hiveKeyIdentifier);
  }
}