import 'dart:developer';

import 'package:akzonobel/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:akzonobel/utils/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_page_state.dart';
import 'bloc/selected_index_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  final appBarHeight = AppBar().preferredSize.height;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    ); // Initialize the TabController
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('Default AppBar Height: $appBarHeight');
    return BlocProvider(
      create: (context) => SelectedIndexCubit(),
      child: Scaffold(
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
            // IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline)),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: SizedBox(
                height: 48,
                width: 24,
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(Images.profile),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2, // Number of tabs
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Past Events',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Center(
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
                    // Past Events Tab
                    ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return EventBanner(
                          title: event.title,
                          dateRange: event.dateRange,
                          imagePath: event.imagePath,
                          location: event.location,
                        );
                      },
                    ),

                    // // Upcoming Events Tab
                    // if (selectedIndex == 0)
                    //   Center(
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Icon(
                    //           Icons.event_busy_outlined,
                    //           color: Colors.blue,
                    //           size: 30,
                    //         ),
                    //         Text(
                    //           'There are no upcoming events at this time.',
                    //           style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
                    //         ),
                    //       ],
                    //     ),
                    //   )
                    // else
                    // // Past Events Tab
                    //   ListView.builder(
                    //     itemCount: events.length,
                    //     itemBuilder: (context, index) {
                    //       final event = events[index];
                    //       return EventBanner(
                    //         title: event.title,
                    //         dateRange: event.dateRange,
                    //         imagePath: event.imagePath,
                    //         location: event.location,
                    //       );
                    //     },
                    //   ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
