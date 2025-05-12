import 'package:flutter/material.dart';

// custom text fields for reuse
class CustomTextFormField extends StatefulWidget {
  final String label;
  final Icon icon;
  final bool isPassword;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.name,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: TextFormField(
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        style: TextStyle(fontFamily: 'Poppins'),
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.label,
          labelStyle: TextStyle(fontFamily: 'Poppins'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText ? Colors.blueAccent[600] : null,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                  : null,
        ),
      ),
    );
  }
}
