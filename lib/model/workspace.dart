class Workspace {
  final String workspace;
  final String companyId;
  final String description;
  final String createdBy;
  final List<String> teams;
  final bool isCompnay;

  Workspace(
      {required this.workspace,
      required this.teams,
      required this.description,
      required this.createdBy,
      this.isCompnay = false,
      this.companyId = ''});
}
