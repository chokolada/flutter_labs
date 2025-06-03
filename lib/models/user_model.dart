class UserModel {
  final String email;
  final String password;

  UserModel({required this.email, required this.password});

  Map<String, String> toMap() => {
    'email': email,
    'password': password,
  };

  factory UserModel.fromMap(Map<String, String> map) => UserModel(
    email: map['email'] ?? '',
    password: map['password'] ?? '',
  );
}