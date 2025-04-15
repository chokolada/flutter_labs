abstract class UserStorage {
  Future<void> saveUser(String email, String password);
  Future<Map<String, String>?> loadUser();
  Future<bool> userExists(String email);
}
