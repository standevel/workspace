class User {
  final String email;
  final String? password;
  final String name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? workspaces;
  String? phone;
  final String? id;

  User(
      {required this.email,
      this.password,
      required this.name,
      this.phone,
      this.workspaces,
      this.createdAt,
      this.updatedAt,
      this.id});
}
