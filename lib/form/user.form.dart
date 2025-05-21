import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:peersync/constants.dart';
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../providers/provider.dart';
import '../validators/unique_email_validator.dart';

class UserForm extends ConsumerWidget {
  final FormGroup form;
  final VoidCallback navigateToCreateWorkspace;

  UserForm({super.key, required this.navigateToCreateWorkspace})
      : form = createForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorPro = ref.watch(errorProvider.notifier);
    final isLoadingProvider = ref.watch(loadingProvider);

    // final signUpResult = ref.watch(signUpResultProvider);

    // final user = User(
    //     email: 'example@example.com',
    //     password: 'password',
    //     firstName: form.value['name'].toString().split(' ')[0],
    //     lastName: form.value['name'].toString().split(' ')[1],
    //     phone: '',
    //     username:
    //         '${form.value['name'].toString().split(' ')[0]}_${form.value['name'].toString().split(' ')[1]}');

    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RoundedPlainTextField(
              formControlName: 'firstName',
              labelText: 'Your first name',
              hintText: "Enter your first name",
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'First Name is required.',
              },
              icon: Icons.house,
              // labelStyle: TextStyle(color: Colors.blueGrey[800]),
              // hintStyle: TextStyle(color: Colors.blueGrey[800]),
              borderRadius: 26,
            ),
            RoundedPlainTextField(
              formControlName: 'lastName',
              labelText: 'Your last name',
              hintText: "Enter your last name",
              validationMessages: {
                ValidationMessage.required: (error) => 'Last Name is required.',
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
                    'email must be a valid email address',
                // ValidationMessage: (error) =>
                //     'email must be a valid email address'
              },
              icon: Icons.email,
              labelText: 'Work Email',
              hintText: 'Enter work Email',
              borderRadius: 26,
            ),

            RoundedPlainTextField(
              formControlName: 'password',
              obscureText: true,
              icon: Icons.password,
              validationMessages: {
                ValidationMessage.required: (error) => 'password is required.',
                ValidationMessage.minLength: (error) =>
                    'The password must be at least ${(error as Map)['requiredLength']} characters long'
              },
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
            isLoadingProvider
                ? const CircularProgressIndicator()
                : const Text(''),
            Text(errorPro.state),
            // signUpResult.when(
            //   data: (result) {
            //     // Parse the result and extract the user ID
            //     final userId = result.user.id;
            //     final token = result.accessToken;
            //     print('access token in form result when ..: $token');
            //     if (userId != null) {
            //       navigateToCreateWorkspace();
            //     }
            //     return const Text('Sign up successful');
            //   },
            //   loading: () => const CircularProgressIndicator(),
            //   error: (error, stackTrace) => Text('Sign-up failed: $error'),
            // ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: Theme.of(context).shadowColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }

  static createForm() {
    return fb.group(
      {
        'firstName': FormControl<String>(validators: [Validators.required]),
        'lastName': FormControl<String>(validators: [Validators.required]),
        'email': FormControl<String>(
          validators: [
            Validators.required,
            Validators.email,
          ],
          asyncValidators: [
            UniqueEmailAsyncValidator(), // custom asynchronous validator :)
          ],
        ),
        // 'confirmEmail': FormControl<String>(validators: [
        //   Validators.required,
        //   Validators.email,
        //   Validators.mustMatch(
        //     'email',
        //     'confirmEmail',
        //   )
        // ]),
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
    print('sign up clicked');
    try {
      if (form.valid) {
        ref.read(errorProvider.notifier).state = '';
        ref.watch(loadingProvider.notifier).state = true;
        print('Sign up form is valid');

        var url = Uri.parse('$api/account');
        var response = await http.post(url, body: form.value);
        print('status code: ${response.statusCode}');
        var body = jsonDecode(response.body);
        var token = body['access_token'];
        var refUser = body['user'];
        print('token: $token body:$body');
        print('user: $refUser');
        if (response.statusCode == 409) {
          ref.read(loadingProvider.notifier).state = false;
          ref.read(errorProvider.notifier).state = body['message'].toString();
        }
        if (token != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(tokenName, token);

          ref.read(tokenProvider.notifier).state = token;
          var user = User(
              email: form.value['email'].toString(),
              password: 'password',
              id: refUser['id'],
              createdAt: refUser['createdAt'],
              profileImageUrl: refUser['profileImageUrl'],
              // firstName: form.value['name'].toString().split(' ')[0],
              // lastName: form.value['name'].toString().split(' ')[1],
              // phone: '',
              // username:
              //     '${form.value['name'].toString().split(' ')[0]}_${form.value['name'].toString().split(' ')[1]}'
              lastName: form.value['lastName'].toString(),
              firstName: form.value['firstName'].toString());
          ref.read(userProvider.notifier).state = user;
          ref.read(loadingProvider.notifier).state = false;

          navigateToCreateWorkspace();
        } else {
          ref.read(loadingProvider.notifier).state = false;
        }
      }
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      ref.read(errorProvider.notifier).state = e.toString();
    }
  }
}
