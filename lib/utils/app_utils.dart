import 'package:akzonobel/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppUtils {
  AppUtils._();

  static final AppUtils _instance =
      AppUtils._(); // this is singleton(Only one instance of a class is created in the entire application,) instance
  static AppUtils get instance =>
      _instance; // this is used in whole project where we need to use this AppUtils(public way to access it)

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
