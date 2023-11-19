import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peersync/model/signup.model.dart';
import 'package:peersync/utils/custom_httpclient.dart';

import '../constants.dart';

class AccountService {
  signUp(SignUp signUp) async {
    var url = Uri.parse('$api/account');
    var response = await http.post(url, body: {
      "email": signUp.email,
      "password": signUp.password,
      "name": signUp.name
    });
    debugPrint('status code: ${response.statusCode}');
    var body = jsonDecode(response.body);
    return body;
  }

  Future<http.Response> findUserTeams(String workspaceId, String token) async {
    var httpClient = CustomHttpClient(bearerToken: token);
    print('getting usr teams');
    var response = await httpClient.get('team/user-teams/$workspaceId');

    return response;
  }

  Future<http.Response> getUserDetails(String token) async {
    print('getting user workspaces: ');
    var httpClient = CustomHttpClient(bearerToken: token);
    var response = await httpClient.get('account/user-details');
    print('user details: ${response.body}');
    return response;
  }
}
