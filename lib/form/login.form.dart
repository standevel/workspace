import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../constants.dart';
import '../model/user.dart';
import '../providers/provider.dart';

class LoginForm extends HookConsumerWidget {
  final FormGroup form;
  final VoidCallback navigateToDashboard;
  LoginForm({required this.navigateToDashboard, super.key})
      : form = createForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          RoundedPlainTextField(
            formControlName: 'email',
            validationMessages: {
              ValidationMessage.required: (error) => 'Email is required.',
              ValidationMessage.email: (control) =>
                  'Please enter a valid email address.',
            },
            labelText: 'Email',
            hintText: 'Enter your email',
            icon: Icons.email,
          ),
          RoundedPlainTextField(
            formControlName: 'password',
            obscureText: true,
            validationMessages: {
              ValidationMessage.required: (control) => 'Password is required.',
              ValidationMessage.minLength: (control) =>
                  'minimum password length is 8'
            },
            labelText: 'Password',
            hintText: 'Enter your password',
            icon: Icons.password,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(''),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/forgot-password');
                },
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Theme.of(context).shadowColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Forgot password?'),
              ),
            ],
          ),
          SubmitForm(title: 'Login', onPressed: () => _submitForm(ref)),
        ]),
      ),
    );
  }

  static FormGroup createForm() {
    return fb.group({
      'email': FormControl<String>(validators: [
        Validators.required,
        Validators.email,
      ]),
      'password': FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(8),
      ]),
    });
  }

  void _submitForm(WidgetRef ref) async {
    if (form.valid) {
      try {
        var url = Uri.parse('$api/account/signin');
        var response = await http.post(url, body: form.value);
        print('body: ${response.statusCode}');
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          // debugPrint('workspace: $body');
          var user = body['user'];
          var token = body['access_token'];

          debugPrint('user: $user');
          debugPrint('access_token: $token');

          ref.read(tokenProvider.notifier).state = token;
          ref.read(userProvider.notifier).state = User(
              name: user['name'].toString(),
              email: user['email'],
              workspaces: user['workspaces'],
              createdAt: DateTime.parse(user['createdAt']),
              updatedAt: DateTime.parse(user['updatedAt']),
              id: user['id']); //body['user'];

          navigateToDashboard();
        } else {
          debugPrint('status code: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint("Error in sign in ${e.toString()}");
      }
    }
  }
}
