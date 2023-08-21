import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peersync/model/signup.model.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

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
}
