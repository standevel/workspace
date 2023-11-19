import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/providers/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const api =
    'http://localhost:3000/api/v1'; // 'https://workspace-api.onrender.com/api/v1'; //;
const chatUrl =
    'http://localhost:3000/chat'; //'https://workspace-api.onrender.com/chat';
const white = Colors.white;
const tokenName = 'peersync_user_token';

Future<String> checkUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userToken = prefs.getString(tokenName)!;
  return userToken;
}

// loadTeamAndWorkspaceFromStorage(WidgetRef ref) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var workspaceString = prefs.get('workspaces');
//   var teamString = prefs.get('teams');
//   if (workspaceString != null || teamString != null) {
//     ref.read(workspaceProvider.future.).state =
//         jsonDecode(workspaceString.toString());
//     ref.read(teamsProvider.notifier).state = jsonDecode(teamString.toString());
//   }
// }

Future<void> setLoggedIn(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<dynamic> setUser(dynamic user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', user.toString());
}

getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get('user');
}

// Retrieving login status
Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

setWorkspaceList(dynamic workspaces) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('workspaces', workspaces.toString());
}

setActiveWorkspace(dynamic activeWorkspace) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('activeWorkspace', activeWorkspace.toString());
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
