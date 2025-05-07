import 'dart:developer';

import 'package:akzonobel/custom_widgets/elevated_button.dart';
import 'package:akzonobel/custom_widgets/text_field.dart';
import 'package:akzonobel/home_page/home_screen.dart';
import 'package:akzonobel/login/bloc/login_bloc.dart';
import 'package:akzonobel/login/bloc/login_event.dart';
import 'package:akzonobel/login/bloc/login_state.dart';
import 'package:akzonobel/resources/images.dart';
import 'package:akzonobel/utils/app_color.dart';
import 'package:akzonobel/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        log('Current State: $state');
        if (state is LoginLoading) {
          // Show loading indicator (optional)
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccess) {
          Navigator.of(context).pop();
          AppUtils.instance.showSnackBar(context, state.successMessage);
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        } else if (state is LoginError) {
          Navigator.of(context).pop();
          AppUtils.instance.showSnackBar(context, state.message);
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
                  onPressed: (){
                    callLoginAPI();
                  },
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

  void callLoginAPI() {
    context.read<LoginBloc>().add(
      LoginInitializeEvent(
        email: emailController.text,
        password: passwordController.text,
        fullName: '',
      ),
    );
  }
}
