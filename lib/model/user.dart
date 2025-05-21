class User {
  final String email;
  final String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? workspaces;
  String? phone;
  final String? id;
  final String? profileImageUrl;
  final String lastName;
  final String firstName;


  User({
    required this.email,
    this.password,
    this.phone,
    this.workspaces,
    this.createdAt,
    this.updatedAt,
    this.id,
    required this.lastName,
    required this.firstName,
    required this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // print('json to user: $json');
    return User(
        email: json['email'],
        password: json['password'] ?? '',
        phone: json['phone'] ?? '',
        workspaces: json['workspaces'], //(json['workspaces'] as List<dynamic>?)
        //?.map((workspace) => Workspace.fromJson(workspace))
        //.toList(),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        id: json['id'],
        lastName: json['lastName'] ?? '',
        firstName: json['firstName'] ?? '',
        profileImageUrl: json['profileImageUrl']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'lastName': lastName,
      'firstName': firstName,
      'profileImageUrl': profileImageUrl
    };

    if (password != null) {
      data['password'] = password;
    }

    if (phone != null) {
      data['phone'] = phone;
    }

    if (workspaces != null) {
      data['workspaces'] = workspaces;
      // ?.map((workspace) => workspace.toJson())
      // .toList(); //members?.map((user) => user.toJson()).toList(),
    }

    if (createdAt != null) {
      data['createdAt'] = createdAt!.toIso8601String();
    }

    if (updatedAt != null) {
      data['updatedAt'] = updatedAt!.toIso8601String();
    }

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}
