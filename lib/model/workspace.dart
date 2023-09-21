class Workspace {
  String? name;
  String? companyId;
  String? description;
  String? createdBy;
  String? logoUrl;
  List<dynamic>? teams;
  bool? isCompany;
  String? id;
  List<dynamic>? members;
  List<dynamic>? publicChannels;

  Workspace(
      this.name,
      this.teams,
      this.description,
      this.createdBy,
      this.logoUrl,
      this.isCompany,
      this.companyId,
      this.id,
      this.members,
      this.publicChannels);

  // Add a toJson method to convert a Workspace object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'companyId': companyId,
      'description': description,
      'createdBy': createdBy,
      'logoUrl': logoUrl,
      'teams': teams,
      'isCompany': isCompany,
      'id': id,
      'members': members,
      'publicChannels': publicChannels
    };
  }

  // Add a factory method to create a Workspace object from a JSON Map
  factory Workspace.fromJson(Map<String, dynamic> json) {
    return Workspace(
        json['name'],
        json['teams'],
        json['description'],
        json['createdBy'],
        json['logoUrl'],
        json['isCompany'],
        json['companyId'],
        json['id'],
        json['members'],
        json['publicChannels']);
  }
}
