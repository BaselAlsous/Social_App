import 'package:flutter/material.dart';

class CustomeTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final Function()? onPressed;
  final IconData? prefixIcon;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  const CustomeTextFormField({
    Key? key,
    required this.textEditingController,
    required this.keyboardType,
    required this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    required this.prefixIcon,
    required this.validator,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blueAccent,
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(suffixIcon),
        ),
      ),
    );
  }
}
