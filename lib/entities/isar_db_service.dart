// import 'package:flutter/material.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:peersync/entities/company.dart';
// import 'package:peersync/entities/team.dart';
// import 'package:peersync/entities/user.dart';
// import 'package:peersync/entities/workspace.dart';

// import 'token.dart';

// class IsarService {
//   late Future<Isar> db;
//   IsarService() {
//     db = openDB();
//     print('db has been opened ');
//   }
//   Future<Isar> openDB() async {
//     if (Isar.instanceNames.isEmpty) {
//       final dir = await getApplicationDocumentsDirectory();
//       return Isar.open(
//         [UserSchema, WorkspaceSchema, CompanySchema, TeamSchema],
//         inspector: true,
//         directory: dir.path,
//       );
//     }
//     return Future.value(Isar.getInstance());
//   }

//   Future<void> saveToken(Token newToken) async {
//     final isar = await db;
//     isar.writeTxnSync<int>(() => isar.tokens.putSync(newToken));
//   }

//   Future<void> saveWorkspace(Workspace newWorkspace) async {
//     final isar = await db;
//     isar.writeTxnSync<int>(() => isar.workspaces.putSync(newWorkspace));
//   }

//   Future<void> saveTeam(Team newTeam) async {
//     final isar = await db;
//     isar.writeTxnSync<int>(() => isar.teams.putSync(newTeam));
//   }

//   Future<User?> findUserByEmail(String email) async {
//     final isar = await db;
//     var found = await isar.users.filter().emailEqualTo(email).findFirst();
//     print('found value: $found');
//     return found;
//   }

//   Future<void> saveUser(dynamic newUser) async {
//     // newUser.userId = newUser.id.toString();
//     var user = User();
//     user.email = newUser.email;
//     user.lastName = newUser.lastName;
//     user.firstName = newUser.firstName;
//     user.phone = newUser.phone;
//     user.userId = newUser.id;
//     user.teams.addAll(newUser.teams);
//     user.workspaces.addAll(newUser.workspaces);

//     final isar = await db;
//     debugPrint('usr to save: $user');
//     isar.writeTxnSync<int>(() => isar.users.putSync(user));
//   }

//   Future<Stream<void>> listenToTeams() async {
//     final isar = await db;

//     return isar.teams.watchLazy(fireImmediately: true);
//     // return;
//   }
// }
