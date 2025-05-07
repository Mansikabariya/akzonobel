import 'dart:developer';

import 'package:akzonobel/custom_widgets/elevated_button.dart';
import 'package:akzonobel/custom_widgets/text_field.dart';
import 'package:akzonobel/home_page/home_screen.dart';
import 'package:akzonobel/l10n/l10n.dart';
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
              context.l10n!.loginToYourAccount,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 120),
            Column(
              children: [
                SizedBox(
                  height: 45,
                  child: CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password field is required';
                      }
                      // Optional: Check for valid email format
                      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                        return 'Enter a valid password';
                      }
                      return '';
                    },
                    hint: context.l10n!.email,
                    controller: emailController,
                    label: context.l10n!.email,
                    icon: Icon(Icons.email, size: 18, color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email field is required';
                      }
                      // Optional: Check for valid email format
                      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return '';
                    },
                    hint: context.l10n!.password,
                    controller: passwordController,
                    isPassword: true,
                    label: context.l10n!.password,
                    icon: Icon(Icons.lock, size: 18, color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 80),
                CustomElevatedButton(
                  onPressed: () {
                    callLoginAPI();
                  },
                  text: context.l10n!.signIn,
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
                            context.l10n!.forgotPassword,
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
                context.l10n!.noAccount,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              onPressed: () {},
              text: context.l10n!.signUp,
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
