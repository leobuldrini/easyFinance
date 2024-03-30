class User {
  final String name;
  final String email;
  final String? photoUrl;
  final String token;
  final double balance;

  User({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.token,
    required this.balance,
  });
}