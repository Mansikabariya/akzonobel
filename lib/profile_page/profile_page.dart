import 'package:akzonobel/home_page/home_screen.dart';
import 'package:akzonobel/login/model/user_data.dart';
import 'package:akzonobel/utils/app_color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final UserData? userData;
  const ProfileScreen({super.key, required this.userData});

  static const route = '/profileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBGColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.route, arguments: widget.userData);
          },
        ),
        title: Text(
          'My Profile',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   height: 200,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: AppColors.toggleWhiteColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
