import 'package:shared_preferences/shared_preferences.dart';
import '../../core/storage/user_storage.dart';

class SharedPrefsUserStorage implements UserStorage {
  @override
  Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Future<Map<String, String>?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  @override
  Future<bool> userExists(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') == email;
  }
}
