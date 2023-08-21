import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RoundedPlainTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;

  final Map<String, String Function(Object)>? validationMessages;

  final String? formControlName;
  final bool? obscureText;
  final FormControl? formControl;
  final String? value;
  final String? labelText;
  final Color? color;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final double? gap;
  const RoundedPlainTextField(
      {Key? key,
      this.hintText,
      this.validationMessages,
      this.formControl,
      this.formControlName,
      this.icon,
      this.color = Colors.white,
      this.borderRadius = 15.0,
      this.gap = 16.0,
      this.labelStyle = const TextStyle(color: Colors.white),
      this.hintStyle = const TextStyle(color: Colors.white),
      this.labelText,
      this.value = '',
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: gap),
        ReactiveTextField(
            formControl: formControl,
            formControlName: formControlName,
            validationMessages: validationMessages,
            obscureText: obscureText!,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                // color: Colors.black,
              ),
              labelText: labelText,
              hintText: hintText,
              labelStyle: labelStyle,
              hintStyle: hintStyle,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
              ),
            )),
        SizedBox(height: gap),
      ],
    );
  }
}
