class Workspace {
  final String workspace;
  final String companyId;
  final String description;
  final String createdBy;
  final String logoUrl;
  final List<String> teams;
  final bool isCompnay;

  Workspace(this.workspace, this.teams, this.description, this.createdBy,
      this.logoUrl, this.isCompnay, this.companyId);
}
