import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peersync/entities/team.dart';
import 'package:peersync/model/signup.model.dart';
import 'package:peersync/utils/custom_httpclient.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  findUserTeams() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('peersync_token');
    var httpClient = CustomHttpClient(bearerToken: token!);
    print('getting usr teams');
    var response = await httpClient.get('/team/user-teams');
    var body = jsonDecode(response.body) as List<Team>;
    return body;
  }
}
