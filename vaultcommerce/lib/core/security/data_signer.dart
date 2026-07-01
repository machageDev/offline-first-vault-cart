import 'dart:convert';
import 'package:crypto/crypto.dart';

class DataSigner {

  static const String _internalSalt = "krypt_cart_zero_trust_salt_2026";

  
  static String generateSignature({
    required String payload,
    required List<int> hardwareKey,
  }) {
    
    final combinedKeyBytes = [...hardwareKey, ...utf8.encode(_internalSalt)];
    
    
    final hmacSha256 = Hmac(sha256, combinedKeyBytes);
    
    
    final dataBytes = utf8.encode(payload);
    final digest = hmacSha256.convert(dataBytes);
    
    // Return the signature as a secure hex string
    return digest.toString();
  }


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