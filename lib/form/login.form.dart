import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm extends HookWidget {
  final FormGroup form;
  LoginForm({super.key}) : form = createForm();

  @override
  Widget build(BuildContext context) {
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
          SubmitForm(
            title: 'Login',
            onPressed: _submitForm,
          ),
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

  void _submitForm() {
    if (form.valid) {
      // Implement your login logic here
      // You can access the form values using form.value
      // For example:
      // final email = form.value['email'];
      // final password = form.value['password'];

      print('Login form is valid!');
    }
  }
}
