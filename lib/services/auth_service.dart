import 'package:laba/core/storage/user_storage.dart';

class AuthService {
  final UserStorage storage;
  AuthService(this.storage);

  Future<bool> register(String email, String password) async {
    final exists = await storage.userExists(email);
    if (exists) return false;
    await storage.saveUser(email, password);
    return true;
  }

  Future<bool> login(String email, String password) async {
    final user = await storage.loadUser();
    return user?['email'] == email && user?['password'] == password;
  }
}
