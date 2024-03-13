import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometricAuthenticationService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    try {
      // Check for biometrics
      if (await isBiometricSupported() && await hasBiometrics()) {
        // Specify the types of biometrics you want to use
        const allowedBiometrics = <BiometricType>[
          BiometricType.face,
          BiometricType.fingerprint,
          BiometricType.iris, // Include iris authentication
        ];

        // Check for specific biometric types (face, fingerprint, iris)
        List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();
        bool canUseIris = availableBiometrics.contains(BiometricType.iris);

        if (canUseIris || availableBiometrics.isNotEmpty) {
          isAuthenticated = await _auth.authenticate(
              localizedReason: 'Please authenticate to access this feature',
              options: const AuthenticationOptions(
                stickyAuth: true,
                biometricOnly: true,
                useErrorDialogs: true,
              ));
        }
      }
    } on PlatformException catch (e) {
      print(e);
    }
    return isAuthenticated;
  }
}