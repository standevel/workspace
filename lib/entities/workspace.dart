import 'package:isar/isar.dart';
import 'user.dart';

import 'company.dart';
import 'team.dart';

// part 'workspace.g.dart';

@Collection()
class Workspace {
  Id? workspaceId = Isar.autoIncrement;
  String? id;
  String? workspace;
  bool? isCompnay;
  String? description;
  final companyId = IsarLink<Company>();
  final createdBy = IsarLink<User>();

  // @Backlink(to: 'workspceId')
  final teams = IsarLinks<Team>();

  @Backlink(to: 'workspaces')
  final members = IsarLinks<User>();
}

// @Backlink(to: 'workspaceId')
// final teams = IsarLinks<Team>();

// @Backlink(to: 'workspaces')
// final members = IsarLinks<User>();
