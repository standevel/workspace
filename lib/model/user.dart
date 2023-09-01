class User {
  final String email;
  final String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? workspaces;
  String? phone;
  final String? id;
  final String lastName;
  final String firstName;
  User(
      {required this.email,
      this.password,
      this.phone,
      this.workspaces,
      this.createdAt,
      this.updatedAt,
      this.id,
      required this.lastName,
      required this.firstName});
}
