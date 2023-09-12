import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peersync/model/user.dart';
import 'package:peersync/model/workspace.dart';
import 'package:peersync/services/account.service.dart';

import '../model/company.dart';
import '../model/team.dart';

final companyProvider = StateProvider<Company?>((ref) => null);
final userProvider = StateProvider<User?>((ref) => null);
final workspaceProvider = StateProvider<Workspace?>((ref) => null);
final tokenProvider = StateProvider<String>((ref) => '');
final loadingProvider = StateProvider((ref) => false);
final errorProvider = StateProvider((ref) => '');

final userTeamsProvider = FutureProvider<List<Team>>((ref) async {
  // Make your API call here to fetch user's teams and return them as a list of Team objects
  AccountService accountService = AccountService();
  final response = await accountService.findUserTeams();
  print('User Teams: $response');
  return response.map((teamData) => Team.fromJson(teamData)).toList();
});
