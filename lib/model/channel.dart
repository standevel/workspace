import 'package:peersync/model/user.dart';

class Channel {
  String? name;
  String? workspaceId;
  String? description;
  String? teamId;
  String? id;
  List<User>? members; // Use List<User> for members

  // Constructor
  Channel({
    this.name,
    this.workspaceId,
    this.description,
    this.teamId,
    this.id,
    this.members,
  });

  // Factory method to create a Channel object from a JSON map
  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      name: json['name'],
      workspaceId: json['workspaceId'],
      description: json['description'],
      teamId: json['teamId'],
      id: json['id'],
      members: (json['members'] as List<dynamic>?)
          ?.map((member) => User.fromJson(member as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert a Channel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'workspaceId': workspaceId,
      'description': description,
      'teamId': teamId,
      'id': id,
      'members': members?.map((user) => user.toJson()).toList(),
    };
  }
}
