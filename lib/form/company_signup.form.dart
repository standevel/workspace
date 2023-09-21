// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:peersync/model/user.dart';
import 'package:peersync/providers/provider.dart';
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../constants.dart';

class CompanyForm extends HookConsumerWidget {
  final FormGroup form;
  final VoidCallback navigateToCreateWorkspace;
  // var company;
  CompanyForm({super.key, required this.navigateToCreateWorkspace})
      : form = createForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isProcessing = ref.watch(loadingProvider);
    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RoundedPlainTextField(
              formControlName: 'companyName',
              labelText: 'Company Name',
              hintText: "Enter your company name",
              validationMessages: {
                ValidationMessage.required: (error) => 'Name is required.',
              },
              icon: Icons.house,
              // labelStyle: TextStyle(color: Colors.blueGrey[800]),
              // hintStyle: TextStyle(color: Colors.blueGrey[800]),
              borderRadius: 26,
            ),

            RoundedPlainTextField(
              formControlName: 'email',
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'work email is required.',
                ValidationMessage.email: (error) =>
                    'email must be a valid email address'
              },
              icon: Icons.email,
              labelText: 'Company Email',
              hintText: 'Enter or your company email',
              borderRadius: 26,
            ),

            const RoundedPlainTextField(
              formControlName: 'password',
              obscureText: true,
              icon: Icons.image,
              // validationMessages: {
              //   ValidationMessage.required: (error) =>
              //       'Company password is required.',
              //   ValidationMessage.minLength: (error) =>
              //       'The password must be at least ${(error as Map)['requiredLength']} characters long'
              // },
              labelText: 'Password',
              hintText: 'Enter Password',
              borderRadius: 26,
            ),
            // RoundedPlainTextField(
            //   formControlName: 'confirmPassword',
            //   obscureText: true,
            //   validationMessages: {
            //     ValidationMessage.required: (error) =>
            //         'confirm password is required.',
            //     ValidationMessage.mustMatch: (error) =>
            //         'confirm password must match with password.',
            //   },
            //   labelText: 'Confirm Password',
            //   hintText: 'Confirm your password',
            //   borderRadius: 26,
            // ),
            SubmitForm(title: 'Continue', onPressed: () => _submitForm(ref)),
            const SizedBox(
              height: 16,
            ),
            if (isProcessing)
              const CircularProgressIndicator(
                color: white,
              )
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed('/login');
            //   },
            //   style: ElevatedButton.styleFrom(
            //     // backgroundColor: Theme.of(context).shadowColor,
            //     foregroundColor: Colors.white,
            //   ),
            //   child: const Text('Already have an account? Login'),
            // ),
          ],
        ),
      ),
    );
  }

  static createForm() {
    return fb.group(
      {
        'companyName': FormControl<String>(validators: [Validators.required]),
        'email': FormControl<String>(validators: [
          Validators.required,
          Validators.email,
        ]),

        'password': FormControl<String>(
            validators: [Validators.required, Validators.minLength(8)]),
        // 'confirmPassword': FormControl<String>(validators: [
        //   Validators.required,
        //   Validators.mustMatch('password', 'confirmPassword')
        // ]),
      },
    );
  }

  void _submitForm(WidgetRef ref) async {
    ref.read(loadingProvider.notifier).state = true;
    print('sign up clicked');
    if (form.valid) {
      try {
        var url = Uri.parse('$api/company');
        var response = await http.post(url, body: form.value);
        var body = jsonDecode(response.body);
        var token = body['access_token'];
        var user = body['user'];
        debugPrint('user: $user token: $token');
        print('status code: ${response.statusCode}');
        if (token != null) {
          ref.read(tokenProvider.notifier).state = token;
        }
        if (user != null) {
          ref.read(userProvider.notifier).state = User.fromJson(user);
          ref.read(loadingProvider.notifier).state = false;
          navigateToCreateWorkspace();
        }
        print('Sign up form is valid');
      } catch (e) {
        debugPrint('company signup error: ${e.toString()}');
        ref.read(loadingProvider.notifier).state = false;
      }
    }
  }
}
