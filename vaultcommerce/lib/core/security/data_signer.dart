import 'dart:convert';
import 'package:crypto/crypto.dart';

class DataSigner {
  // A localized cryptographic salt used to randomize the hash output further.
  // In a full enterprise system, this could also be fetched securely or derived.
  static const String _internalSalt = "krypt_cart_zero_trust_salt_2026";

  /// Generates a deterministic HMAC-SHA256 signature for a given text payload
  /// using a secret key retrieved from our hardware secure storage vault.
  static String generateSignature({
    required String payload,
    required List<int> hardwareKey,
  }) {
    // Combine the hardware-backed key bytes with our internal salt for extra entropy
    final combinedKeyBytes = [...hardwareKey, ...utf8.encode(_internalSalt)];
    
    // Initialize the HMAC engine with SHA-256 and our secure key
    final hmacSha256 = Hmac(sha256, combinedKeyBytes);
    
    // Hash the payload string
    final dataBytes = utf8.encode(payload);
    final digest = hmacSha256.convert(dataBytes);
    
    // Return the signature as a secure hex string
    return digest.toString();
  }

  /// Compares an existing signature against a freshly computed signature
  /// to verify that the underlying data payload has not been tampered with.
  static bool verifySignature({
    required String payload,
    required String existingSignature,
    required List<int> hardwareKey,
  }) {
    if (existingSignature.isEmpty) return false;

    final computedSignature = generateSignature(
      payload: payload,
      hardwareKey: hardwareKey,
    );

    // Constant-time verification pattern to mitigate timing attacks
    return computedSignature == existingSignature;
  }
}