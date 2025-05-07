import 'package:flutter/material.dart';

// custom text fields for reuse
class CustomTextFormField extends StatefulWidget {
  final String label;
  final Icon icon;
  final bool isPassword;
  final TextEditingController controller;
  final String hint;
  final String Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    required this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: TextFormField(
        style: TextStyle(height: 0.7),
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword ? _obscureText : false,
        cursorColor: Colors.black,
        cursorHeight: 20,
        cursorWidth: 1.5,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusColor: Colors.blueAccent[600],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
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
