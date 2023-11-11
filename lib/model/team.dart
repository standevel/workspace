// Assuming you have a User class defined

class Team {
  String? name;
  String? description;
  String? workspaceId;
  List<dynamic>? members; // Updated to List<User>
  List<dynamic>? channels;
  DateTime? createdAt;
  DateTime? updatedAt;
  // Add a toJson method to convert a Team object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'workspaceId': workspaceId,
      'members': members, //?.map((user) => user.toJson()).toList(),
      'channels': channels, //?.map((channel) => channel.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Add a factory method to create a Team object from a JSON Map
  factory Team.fromJson(Map<String, dynamic> json) {
    print('team json $json');
    var team = Team(
      name: json['name'],
      description: json['description'],
      workspaceId: json['workspaceId'],
      members: json['members'],
      // (json['members'] as List<dynamic>?)
      //     ?.map((memberJson) => User.fromJson(memberJson))
      //     .toList(), // Deserialize JSON to List<User>
      channels: json['channels'],
      // (json['channels'] as List<dynamic>?)!
      //     .map((chan) => Channel.fromJson(chan))
      //     .toList(), // Deserialize JSON to Channel
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
    print('team created $team');
    return team;
  }

  Team({
    this.name,
    this.description,
    this.workspaceId,
    this.members,
    this.channels,
    this.createdAt,
    this.updatedAt,
  });
}
