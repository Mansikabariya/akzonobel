import 'package:akzonobel/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils{
  AppUtils._();

  static final AppUtils _instance = AppUtils._();
  static AppUtils get instance => _instance;


  void showSnackBar(
      BuildContext context,
      String message, {
        SnackBarAction? action,
      }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: AppColors.toggleBlueColor,
        content: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    // color: CricketColors.kWhiteColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
        action: action,
      ),
    );
  }
}