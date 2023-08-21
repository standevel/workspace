import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SubmitForm extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SubmitForm({super.key, this.title = 'Submit', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    // void submitForm() {
    //   final form = ReactiveForm.of(context);
    //   print('sign up clicked');
    //   if (form!.valid) {
    //     print('Sign up form is valid');
    //   }
    // }

    return Padding(
      padding: const EdgeInsets.all(
          30.0), // Set the padding around the ElevatedButton
      child: ElevatedButton(
        onPressed: form!.valid ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).shadowColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20.0), // Set the padding within the ElevatedButton
          // You can also customize other properties of the ElevatedButton style here
        ),
        child: Text(title),
      ),
    );
  }
}
