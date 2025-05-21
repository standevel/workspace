// import 'package:objectbox/objectbox.dart';
// import 'user.dart';

// import 'company.dart';
// import 'team.dart';

// // part 'workspace.g.dart';

// @Entity()
// class Workspace {
//   @Id()
//   int workspaceId = 0;
//   @Index()
//   String? id;
//   bool? isCompnay;
//   String? description;
//   String? companyId;
//   String? createdBy;
//   final teams = ToMany<Team>();
//   // final workspace = ToMany<Workspace>();
//   final members = ToMany<User>();
// }

// // @Backlink(to: 'workspaceId')
// // final teams = IsarLinks<Team>();

// // @Backlink(to: 'workspaces')
// // final members = IsarLinks<User>();
