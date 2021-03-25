import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static LocalAuthApi _instance = LocalAuthApi.internal();
  LocalAuthApi.internal();
  factory LocalAuthApi() => _instance;

  static final _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    bool isAvailable;

    try {
      isAvailable = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }

    if (!isAvailable) {
      return false;
    } else {
      try {
        return await _auth.authenticateWithBiometrics(
          localizedReason: 'Scan to authenticate',
          useErrorDialogs: true,
          stickyAuth: false,
        );
      } on PlatformException catch (e) {
        print(e);
        return false;
      }
    }
  }
}
