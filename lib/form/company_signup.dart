import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CompanySignUpForm extends HookWidget {
  final FormGroup form;
  CompanySignUpForm({super.key}) : form = createForm();

  @override
  Widget build(
    BuildContext context,
  ) {
    // final company = ref.watch(companyProvider);
//  useEffect(() {
//       final formSubscription = form.valueChanges.listen((_) {
//         form.markAllAsTouched();
//       });
//       return () => formSubscription.cancel(); // Cleanup the subscription
//     }, []);
    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RoundedPlainTextField(
              formControlName: 'companyName',
              labelText: 'Company Name',
              hintText: "Enter Company Name",
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'Company name is required.',
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
                    'Company email is required.',
                ValidationMessage.email: (error) =>
                    'email must be a valid email address'
              },
              icon: Icons.email,
              labelText: 'Company Email',
              hintText: 'Enter Company Email',
              borderRadius: 26,
            ),

            RoundedPlainTextField(
              formControlName: 'password',
              obscureText: true,
              icon: Icons.password,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'Company password is required.',
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
            SubmitForm(title: 'Sign Up', onPressed: _submitForm),
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
        'companyName': FormControl<String>(validators: [Validators.required]),
        'email': FormControl<String>(validators: [
          Validators.required,
          Validators.email,
        ]),
        // 'confirmEmail': FormControl<String>(validators: [
        //   Validators.required,
        //   Validators.email,
        //   Validators.mustMatch(
        //     'email',
        //     'confirmEmail',
        //   )
        // ]),
        'password': FormControl<String>(validators: [
          Validators.required,
        ]),
        // 'confirmPassword': FormControl<String>(validators: [
        //   Validators.required,
        //   Validators.mustMatch('password', 'confirmPassword')
        // ]),
      },
    );
  }

  void _submitForm() {
    print('sign up clicked');
    if (form.valid) {
      print('Sign up form is valid');
    }
  }
}
