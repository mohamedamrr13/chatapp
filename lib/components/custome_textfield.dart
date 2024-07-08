import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield(
      {super.key,
      this.onChanged,
      this.title,
      required this.obscure,
      this.icon});
  final String? title;
  Widget? icon;
  Function(String)? onChanged;
  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      validator: (data) {
        if (data?.isEmpty ?? true) return 'Field is required.';
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          suffixIcon: icon,
          helperStyle: const TextStyle(color: Colors.white),
          hintText: title,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
