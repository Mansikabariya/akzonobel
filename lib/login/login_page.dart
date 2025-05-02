import 'package:akzonobel/home_page/home_screen.dart';
import 'package:akzonobel/login/bloc/login_bloc.dart';
import 'package:akzonobel/login/bloc/login_event.dart';
import 'package:akzonobel/login/bloc/login_state.dart';
import 'package:akzonobel/resources/images.dart';
import 'package:akzonobel/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // static const route = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin(BuildContext context) {
    final String enteredEmail = emailController.text.trim();
    final String enteredPassword = passwordController.text.trim();

    context.read<LoginBloc>().add(
      LoginButtonPressed(email: enteredEmail, password: enteredPassword),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          CircularProgressIndicator();
        } else if (state is LoginSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.mainBGColor,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(Images.logo),
            ),
            const SizedBox(height: 20),
            Text(
              'Log in to your account',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 120),
            Column(
              children: [
                SizedBox(
                  height: 45,
                  child: CustomTextFormField(
                    hint: 'Enter email',
                    controller: emailController,
                    label: 'Email',
                    icon: Icon(Icons.email, size: 18, color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: CustomTextFormField(
                    hint: 'Enter Password',
                    controller: passwordController,
                    isPassword: true,
                    label: 'Password',
                    icon: Icon(Icons.lock, size: 18, color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 80),
                CustomElevatedButton(
                  onPressed: () => handleLogin(context),
                  text: 'SIGN IN',
                  height: 45,
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                  buttonType: ButtonType.filled,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                'Don\'t Have An Account?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              onPressed: () {},
              text: 'SIGN UP',
              height: 45,
              textStyle: Theme.of(context).textTheme.titleSmall,
              buttonType: ButtonType.outlined,
            ),
          ],
        ),
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
  final String hint;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
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
        style: TextStyle(height: 0.7),
        controller: widget.controller,
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
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
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
