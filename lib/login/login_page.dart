import 'package:akzonobel/resources/images.dart';
import 'package:akzonobel/utils/theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(Images.logo),
          ),
          const SizedBox(height: 20),
          Text(
            'Log in to your account',
            style: TTextTheme.lightTheme.displayMedium,
          ),
          const SizedBox(height: 80),
          CustomTextFormField(
            label: 'Email',
            icon: Icon(Icons.email),
            controller: emailController,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Password',
            icon: Icon(Icons.lock),
            controller: passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Colors.blue[900]!,
                  Colors.blue[600]!,
                  Colors.blue[400]!,
                  Colors.blue[300]!,
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: TElevatedButtonTheme.lightButtonTheme.style,
              child: Text('SIGN IN'),
            ),
          ),
        ],
      ),
    );
  }
}

// custom text fields for reuse
class CustomTextFormField extends StatefulWidget {
  final String label;
  final Icon icon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    required this.controller,
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
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.label,
          labelStyle: TTextTheme.lightTheme.labelSmall,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? (Icons.visibility_off) : (Icons.visibility),
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
