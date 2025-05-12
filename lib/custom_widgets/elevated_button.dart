

import 'package:flutter/material.dart';
// reusable Button
enum ButtonType { filled, outlined }

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final double height;
  final List<Color> gradientColors;
  final ButtonType buttonType;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.height = 45,
    this.gradientColors = const [
      Color(0xFF0D47A1),
      Color(0xFF1565C0),
      Color(0xFF1976D2),
      Color(0xFF1E88E5),
      Color(0xFF2196F3),
      Color(0xFF42A5F5),
    ],
    this.buttonType = ButtonType.filled,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);

    if (buttonType == ButtonType.outlined) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: BorderSide(color: Colors.blue[700]!),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Text(
            text,
            style:
            textStyle ??
                TextStyle(
                  color: Colors.blue[700],
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    // Filled gradient button
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(colors: gradientColors),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}