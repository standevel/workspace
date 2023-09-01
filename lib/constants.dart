import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entities/user.dart';
import 'entities/workspace.dart';

const api = 'https://workspace-api.onrender.com/api/v1';

const white = Colors.white;
const tokenName = 'peersync_user_token';

Future<String> checkUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userToken = prefs.getString(tokenName)!;
  return userToken;
}

// getDBInstance() async {
//   final dir = await getApplicationDocumentsDirectory();
//   Isar isar;
//   isar ??= await Isar.open(
//     [UserSchema, WorkspaceSchema],
//     directory: dir.path,
//   );
//   return isar;
// }
// getCollection() async {
// // Create a box collection
//   final collection = await BoxCollection.open(
//     'peersync', // Name of your database
//     {
//       'users',
//       'workspaces',
//       'companies',
//       'channels',
//       'teams',
//       'messages',
//     }, // Names of your boxes
//     path:
//         './', // Path where to store your boxes (Only used in Flutter / Dart IO)
//     key:
//         HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
//   );
//   return collection;
// }
