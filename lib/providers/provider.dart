import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peersync/model/user.dart';
import 'package:peersync/model/workspace.dart';

import '../model/company.dart';

final companyProvider = StateProvider<Company?>((ref) => null);
final userProvider = StateProvider<User?>((ref) => null);
final workspaceProvider = StateProvider<Workspace?>((ref) => null);
final tokenProvider = StateProvider<String>((ref) => '');
final loadingProvider = StateProvider((ref) => false);
final errorProvider = StateProvider((ref) => '');
