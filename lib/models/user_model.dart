class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}
