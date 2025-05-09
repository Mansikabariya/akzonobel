// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventData _$EventDataFromJson(Map<String, dynamic> json) => EventData(
  eventId: (json['event_id'] as num?)?.toInt(),
  eventName: json['event_name'] as String?,
  color: json['color'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  interaryPdf: json['interary_pdf'] as String?,
  interaryText: json['interary_text'] as String?,
  bookingPdf: json['booking_pdf'] as String?,
  bookingText: json['booking_text'] as String?,
  userId: (json['user_id'] as num?)?.toInt(),
  countrieId: (json['countrie_id'] as num?)?.toInt(),
  flag: json['flag'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  addresses:
      (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
  banners:
      (json['banners'] as List<dynamic>?)
          ?.map((e) => EventBanner.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$EventDataToJson(EventData instance) => <String, dynamic>{
  'event_id': instance.eventId,
  'event_name': instance.eventName,
  'color': instance.color,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'interary_pdf': instance.interaryPdf,
  'interary_text': instance.interaryText,
  'booking_pdf': instance.bookingPdf,
  'booking_text': instance.bookingText,
  'user_id': instance.userId,
  'countrie_id': instance.countrieId,
  'flag': instance.flag,
  'state': instance.state,
  'country': instance.country,
  'addresses': instance.addresses,
  'banners': instance.banners,
};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  address: json['address'] as String?,
  longitude: json['longitude'] as String?,
  latitude: json['latitude'] as String?,
  destinationOverviewFreeText:
      json['destination_overview_free_text'] as String?,
  interestingFactsFreeText: json['interesting_facts_free_text'] as String?,
  addpdf: json['addpdf'] as String?,
  primary: (json['primary'] as num?)?.toInt(),
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'address': instance.address,
  'longitude': instance.longitude,
  'latitude': instance.latitude,
  'destination_overview_free_text': instance.destinationOverviewFreeText,
  'interesting_facts_free_text': instance.interestingFactsFreeText,
  'addpdf': instance.addpdf,
  'primary': instance.primary,
};

EventBanner _$EventBannerFromJson(Map<String, dynamic> json) => EventBanner(
  id: (json['id'] as num?)?.toInt(),
  bannerPath: json['banner_path'] as String?,
);

Map<String, dynamic> _$EventBannerToJson(EventBanner instance) =>
    <String, dynamic>{'id': instance.id, 'banner_path': instance.bannerPath};
