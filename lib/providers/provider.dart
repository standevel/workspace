import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peersync/model/signup.model.dart';
import 'package:peersync/model/user.dart';
import 'package:peersync/model/workspace.dart';
import 'package:peersync/services/account.service.dart';

import '../model/Signup_result.dart';
import '../model/company.dart';

final companyProvider = StateProvider<Company?>((ref) => null);
final userProvider = StateProvider<User?>((ref) => null);
final workspaceProvider = StateProvider<Workspace?>((ref) => null);
final tokenProvider = StateProvider<String>((ref) => '');
final loadingProvider = StateProvider((ref) => false);
final errorProvider = StateProvider((ref) => '');

final signUpResultProvider = FutureProvider<SignUpResult>((ref) async {
  final user = ref.watch(userProvider);
  AccountService accountService = AccountService();
  if (user != null) {
    var body = accountService.signUp(
        SignUp(name: user.name, email: user.email, password: user.password!));
    var token = body['access_token'];
    // ref.watch(tokenProvider.notifier).state = token;
    // var resUser = body['user'];
    // ref.watch(userProvider.notifier).state = User(
    //     username: user.username,
    //     email: user.email,
    //     password: user.password,
    //     firstName: user.firstName,
    //     lastName: user.lastName,
    //     phone: user.phone,
    //     id: resUser['id']);
    debugPrint('token: $token user:$user');
    debugPrint('user: $user');
    return SignUpResult(token, user);
  }
  return SignUpResult('', user!);
});
