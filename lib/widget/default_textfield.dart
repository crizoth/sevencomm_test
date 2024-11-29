import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/app_colors.dart';

class DefaultTextField extends StatelessWidget {
  String? hint;
  TextEditingController? controller;
  bool obsureText;
  bool isPasswordField;
  void Function(String)? onChanged;

  DefaultTextField(
      {this.hint,
      this.controller,
      this.obsureText = false,
      this.isPasswordField = false,
      this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        hintText: hint ?? '',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
      onChanged: onChanged,
    );
  }
}
