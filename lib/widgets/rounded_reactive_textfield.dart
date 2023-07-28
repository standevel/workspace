import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RoundedReactiveTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final ValueChanged<void>? onChanged;
  final TextEditingController? controller;
  final int? maxLines;
  final bool obscureText;
  final ValueChanged<void>? onSubmitted;
  final String? formControlName;
  final FormControl? formControl;
  final Color? textColor;
  final bool enableSuggestion;
  final Map<String, String Function(Object)>? validationMessages;
  final bool autofocus;
  final String labelText;

  const RoundedReactiveTextField(
      {Key? key,
      this.hintText,
      this.icon,
      this.onChanged,
      this.color = Colors.white,
      this.backgroundColor = Colors.blueAccent,
      this.controller,
      this.obscureText = false,
      this.maxLines = 1,
      this.enableSuggestion = false,
      this.autofocus = false,
      this.onSubmitted,
      this.formControlName,
      this.formControl,
      this.textColor = Colors.white,
      this.validationMessages,
      this.labelText = ''})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(36),
      ),
      child: ReactiveTextField(
        formControl: formControl,
        formControlName: formControlName,
        maxLines: maxLines,
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        cursorColor: color,
        obscureText: obscureText,
        enableSuggestions: enableSuggestion,
        autofocus: autofocus,
        style: TextStyle(color: textColor),
        validationMessages: validationMessages,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: color,
          ),
          hintText: hintText,
          // label: Text(labelText),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: color),
          border: InputBorder.none,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
