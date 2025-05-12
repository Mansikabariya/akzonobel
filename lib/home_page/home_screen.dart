import 'dart:developer';
import 'package:akzonobel/home_page/bloc/home_page_bloc.dart';
import 'package:akzonobel/home_page/bloc/home_page_event.dart';
import 'package:akzonobel/login/model/user_data.dart';
import 'package:akzonobel/profile_page/profile_page.dart';
import 'package:akzonobel/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:akzonobel/utils/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_page_state.dart';
import 'bloc/selected_index_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userData});

  final UserData? userData;

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

    // Initial fetch for Upcoming events (type 1)
    context.read<HomePageBloc>().add(const FetchEvent(offset: '0', type: '1'));

    // Listen to tab changes and fetch accordingly
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return; // Prevent double calls

      final type = _tabController.index == 0 ? '1' : '2';
      context.read<HomePageBloc>().add(FetchEvent(offset: '0', type: type));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
              Text(
                widget.userData!.fullName ?? 'Guest',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline)),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: SizedBox(
                height: 48,
                width: 24,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      ProfileScreen.route,
                    );
                  },
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: CachedNetworkImageProvider(
                      widget.userData!.profilePicture ?? '',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2,
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
                    // UPCOMING EVENTS TAB
                    BlocBuilder<HomePageBloc, EventState>(
                      builder: (context, state) {
                        if (state is EventLoading && state.type == '1') {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is EventLoaded && state.type == '1') {
                          if (state.events.isEmpty) {
                            return Center(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: state.events.length,
                            itemBuilder: (context, index) {
                              final event = state.events[index];
                              return EventBanner(
                                title: event.title,
                                startDate: event.startDate,
                                endDate: event.endDate,
                                imagePath: event.imagePath,
                                location: event.location,
                              );
                            },
                          );
                        } else if (state is EventError) {
                          return Center(child: Text(state.errorMessage));
                        }
                        return const SizedBox();
                      },
                    ),

                    //PAST EVENTS TAB
                    BlocBuilder<HomePageBloc, EventState>(
                      builder: (context, state) {
                        if (state is EventLoading && state.type == '2') {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is EventLoaded && state.type == '2') {
                          if (state.events.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.event_busy_outlined,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                  Text(
                                    'There are no past events at this time.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: state.events.length,
                            itemBuilder: (context, index) {
                              final event = state.events[index];
                              return EventBanner(
                                title: event.title,
                                startDate: event.startDate,
                                endDate: event.endDate,
                                imagePath: event.imagePath,
                                location: event.location,
                              );
                            },
                          );
                        } else if (state is EventError) {
                          return Center(child: Text(state.errorMessage));
                        }
                        return const SizedBox(); // Empty fallback
                      },
                    ),
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
  final String startDate;
  final String endDate;
  final String title;
  final String location;

  const EventBanner({
    super.key,
    required this.imagePath,
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget:
                    (context, url, error) => CachedNetworkImage(
                      imageUrl: TheAppConstants.defaultBanner,
                      fit: BoxFit.cover,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            title,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.event,
                              color: Colors.black54,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Start: $startDate',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.event_available,
                              color: Colors.black54,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'End: $endDate',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
