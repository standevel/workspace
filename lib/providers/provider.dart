import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peersync/constants.dart';
import 'package:peersync/model/channel.dart';
import 'package:peersync/model/message.dart';
import 'package:peersync/model/user.dart';
import 'package:peersync/model/workspace.dart';
import 'package:peersync/services/account.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enums/event_type.enum.dart';
import '../model/company.dart';
import '../model/event_payload.dart';
import '../model/team.dart';
import 'socket_manager.dart';

final companyProvider = StateProvider<Company?>((ref) => null);
final userProvider = StateProvider<User?>((ref) => null);
final workspaceProvider = StateProvider<Workspace?>((ref) => null);
final activeChannelProvider = StateProvider<Channel>((ref) => Channel(
    description: '',
    id: '',
    name: '',
    members: [],
    teamId: '',
    workspaceId: ''));

final workspacesProvider = FutureProvider<List<Workspace>?>((ref) async {
  print('get workspaces process started...');
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString(tokenName);
  print('token to apply $token');
  var userString = pref.getString('user');
  print('user string $userString');
  var foundWorkspacesString = pref.getString('workspaces');

  token ??= ref.read(tokenProvider);
  // user ??= ref.read(userProvider);
  // print('user id: $user token: $token');
  AccountService accountService = AccountService();
  print(' account service has been initialized ');
  final response = await accountService.getUserDetails(token!);
  print(' get user data status: ${response.statusCode}');
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);

    var workspaces = body['workspaces'] as List<dynamic>;
    pref.setString('workspaces', workspaces.toString());
    if (body['activeWorkspace'] != null) {
      ref.read(workspaceProvider.notifier).state =
          Workspace.fromJson(body['activeWorkspace'] as dynamic);
    } else {
      ref.read(workspaceProvider.notifier).state =
          Workspace.fromJson(workspaces.elementAt(0));
    }
    final List<dynamic> teamDataList =
        ref.read(workspaceProvider)!.teams!.toList();
    final List<Team> teamsData =
        teamDataList.map((team) => Team.fromJson(team)).toList();

    ref.read(teamsProvider.notifier).state = teamsData;
    List<String> channelIds = [];
    if (teamsData.isNotEmpty) {
      for (var e in teamsData) {
        e.channels?.forEach((element) {
          channelIds.add(element['id']);
        });
      }
      print('channel Ids: $channelIds');
    }
    if (ref.read(workspaceProvider)!.publicChannels!.isNotEmpty) {
      ref.read(workspaceProvider)!.publicChannels?.forEach((element) {
        channelIds.add(element['id']);
      });
    }
    if (channelIds.isNotEmpty) {
      String event = EventType.JOIN_CHANNELS.name.toString();

      // Convert using the custom encoder
      var payload =
          EventPayload(type: EventType.JOIN_CHANNELS, data: channelIds);
      print('jsonEncoded event $event');
      SocketManager manager = SocketManager();
      manager.emitMessage(payload);
    }
    print('updated channel ids: $channelIds');

    return workspaces
        .map((workspace) => Workspace.fromJson(workspace))
        .toList();
  } else {
    return null;
  }
});

final tokenProvider = StateProvider<String>((ref) => '');
final loadingProvider = StateProvider((ref) => false);
final errorProvider = StateProvider((ref) => '');
final teamsProvider = StateProvider<List<Team>?>((ref) => null);

final userTeamsProvider = FutureProvider<List<Team>>((ref) async {
  print('fetching user teams');
  // Make your API call here to fetch user's teams and return them as a list of Team objects
  AccountService accountService = AccountService();
  var workspace = ref.read(workspaceProvider)!;
  // var teams
  print('workspace in provider ${workspace.teams}');
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString('peersync_token');
  print('token to apply $token');
  token ??= ref.read(tokenProvider);
  print('workspace id: ${workspace.id} token: $token');
  final response = await accountService.findUserTeams(workspace.id!, token!);

  print('status: ${response.statusCode}');
  var body = jsonDecode(response.body);
  print('User Teams: $body');
  return body.map((teamData) => Team.fromJson(teamData)).toList();
});

final allMessagesProvider = StateProvider<List<Message>>((ref) => []);
final activeChannelMessagesProvider = StateProvider<List<Message>>((ref) => []);
final activeDMMessagesProvider = StateProvider<List<Message>>((ref) => []);
final newMessageProvider = StateProvider<Message?>((ref) => null);
