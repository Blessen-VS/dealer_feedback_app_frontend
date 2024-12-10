import 'package:flutter/material.dart';

class CustomTextFieldLanding extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType; // Add this line
  final String? Function(String?)? validator;

  const CustomTextFieldLanding({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType, // Add this line
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator, // Support validation
    );
  }
}
