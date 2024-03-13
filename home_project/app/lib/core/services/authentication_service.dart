import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  final _storage = FlutterSecureStorage();
  final String _key = 'userToken';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _key);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }

  // Example method to demonstrate a login process
  Future<bool> login(String username, String password) async {
    // Simulate a network request to authenticate the user
    await Future.delayed(Duration(seconds: 1));
    if (username == 'user' && password == 'password') {
      // Simulate saving a token on successful login
      await saveToken('fake_token');
      return true;
    } else {
      return false;
    }
  }

  // Example method to demonstrate a logout process
  Future<void> logout() async {
    // Simulate a network request to logout the user
    await Future.delayed(Duration(seconds: 1));
    // Delete the saved token on logout
    await deleteToken();
  }
}