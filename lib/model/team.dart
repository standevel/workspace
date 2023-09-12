class Team {
  String? name;
  String? description;
  String? workspaceId;
  String? members;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Add a toJson method to convert a Team object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'workspaceId': workspaceId,
      'members': members,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Add a factory method to create a Team object from a JSON Map
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      description: json['description'],
      workspaceId: json['workspaceId'],
      members: json['members'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Team({
    this.name,
    this.description,
    this.workspaceId,
    this.members,
    this.createdAt,
    this.updatedAt,
  });
}
