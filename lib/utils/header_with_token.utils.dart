import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class CustomHttpClient {
  final String baseUrl;
  final String bearerToken;

  CustomHttpClient({this.baseUrl = api, required this.bearerToken});

  Map<String, String> getHeaders() {
    return {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    };
  }

  Future<http.Response> get(String path) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$path'),
      headers: getHeaders(),
    );
    return response;
  }

  Future<http.Response> post(String path, dynamic data) async {
    debugPrint('full url: $baseUrl/$path');
    final response = await http.post(
      Uri.parse('$baseUrl/$path'),
      headers: getHeaders(),
      body: jsonEncode(data),
    );
    debugPrint('workspace response: ${response.body}');
    return response;
  }

  Future<http.Response> patch(String path, dynamic data) async {
    debugPrint('full url: $baseUrl/$path');
    final response = await http.patch(
      Uri.parse('$baseUrl/$path'),
      headers: getHeaders(),
      body: jsonEncode(data),
    );
    debugPrint('workspace response: ${response.body}');
    return response;
  }

  Future<http.Response> put(String path, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$path'),
      headers: getHeaders(),
      body: jsonEncode(data),
    );
    return response;
  }

  Future<http.Response> delete(String path) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$path'),
      headers: getHeaders(),
    );
    return response;
  }
}
