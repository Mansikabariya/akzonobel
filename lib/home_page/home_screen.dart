import 'dart:developer';

import 'package:akzonobel/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:akzonobel/utils/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    log('Default AppBar Height: $appBarHeight');
    return Scaffold(
      backgroundColor: AppColors.mainBGColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainBGColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome', style: Theme.of(context).textTheme.titleMedium),
            Text('Mansi', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.person_outline)),
          SizedBox(
            height: 48,
            width: 48,
            // color: Colors.lightBlue,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 12),
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage(Images.profile),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    alignment: Alignment(10, 10),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            selectedIndex == 0
                                ? AppColors.toggleBlueColor
                                : AppColors.toggleWhiteColor,
                        boxShadow: const [
                          BoxShadow(blurRadius: 4, offset: Offset(0, 2)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                selectedIndex == 0
                                    ? AppColors.toggleBlueColor
                                    : AppColors.toggleTransparent,
                          ),
                          child: InkWell(
                            onTap: () => setState(() => selectedIndex = 0),
                            child: Center(
                              child: Text(
                                'Upcoming Events',
                                style: TextStyle(
                                  color:
                                      selectedIndex == 0
                                          ? AppColors.toggleWhiteColor
                                          : AppColors.blackColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                selectedIndex == 1
                                    ? AppColors.toggleBlueColor
                                    : AppColors.toggleTransparent,
                          ),
                          child: InkWell(
                            onTap: () => setState(() => selectedIndex = 1),
                            child: Center(
                              child: Text(
                                'Past Events',
                                style: TextStyle(
                                  color:
                                      selectedIndex == 1
                                          ? AppColors.toggleWhiteColor
                                          : AppColors.blackColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 30),
          if (selectedIndex == 0)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.event_busy_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                    Text(
                      'There are no upcoming events at this time.',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EventBanner(
                      title: 'Testing event',
                      dateRange: '19 Jul | 23 Jul - 2024',
                      imagePath: Images.banner,
                      location: 'Ahmedabad',
                    ),
                    EventBanner(
                      title: 'Test event',
                      dateRange: '15 Feb | 18 Feb - 2025',
                      imagePath: Images.banner_2,
                      location: 'Intelivita,Ahmedabad',
                    ),
                    EventBanner(
                      title: 'Test event',
                      dateRange: '15 Feb | 18 Feb - 2025',
                      imagePath: Images.banner_3,
                      location: 'Intelivita,Ahmedabad',
                    ),
                    EventBanner(
                      title: 'Testing event',
                      dateRange: '19 Jul | 23 Jul - 2024',
                      imagePath: Images.banner_4,
                      location: 'Ahmedabad',
                    ),
                    EventBanner(
                      title: 'Testing event',
                      dateRange: '19 Jul | 23 Jul - 2024',
                      imagePath: Images.banner_5,
                      location: 'Ahmedabad',
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class EventBanner extends StatelessWidget {
  final String imagePath;
  final String dateRange;
  final String title;
  final String location;

  const EventBanner({
    super.key,
    required this.imagePath,
    required this.dateRange,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 137,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 23,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          dateRange,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              location,
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium!.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
