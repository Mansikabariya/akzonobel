import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../model/pass_events/event_data.dart';

class Event {
  final String title;
  // final String dateRange;
  final String startDate;
  final String endDate;
  final String imagePath;
  final String location;

  Event({
    required this.title,
    // required this.dateRange,
    required this.startDate,
    required this.endDate,
    required this.imagePath,
    required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    String startDateRaw = json['start_date'] ?? '';
    String endDateRaw = json['end_date'] ?? '';

    String formatDate(String dateStr) {
      try {
        DateTime date = DateTime.parse(dateStr);
        return DateFormat('d MMM yyyy').format(date);
      } catch (e) {
        return dateStr;
      }
    }

    String startDate = formatDate(startDateRaw);
    String endDate = formatDate(endDateRaw);
    String startdate = startDate;
    String enddate = endDate;

    String location = '';
    if (json['addresses'] != null && (json['addresses'] as List).isNotEmpty) {
      location = json['addresses'][0]['address'] ?? '';
    }

    String imagePath = '';
    if (json['banners'] != null && (json['banners'] as List).isNotEmpty) {
      final banner = EventBanner.fromJson(json['banners'][0]);
      imagePath = banner.bannerPath ?? '';
    }

    log("Image path: $imagePath");

    return Event(
      title: json['event_name'] ?? '',
      // dateRange: dateRange,
      startDate: startdate,
      endDate: enddate,
      imagePath: imagePath,
      location: location,
    );
  }
}


class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object?> get props => [];
}

class FetchEvent extends EventsEvent
{

  const FetchEvent({required this.offset, required this.type});

  final String offset;
  final String type;
}
