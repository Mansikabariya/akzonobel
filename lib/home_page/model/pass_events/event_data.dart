import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_data.g.dart';

@JsonSerializable()
class EventData extends Equatable {
  const EventData({
    this.eventId,
    this.eventName,
    this.color,
    this.startDate,
    this.endDate,
    this.interaryPdf,
    this.interaryText,
    this.bookingPdf,
    this.bookingText,
    this.userId,
    this.countrieId,
    this.flag,
    this.state,
    this.country,
    this.addresses,
    this.banners,
  });

  factory EventData.fromJson(Map<String, dynamic> json) =>
      _$EventDataFromJson(json);

  @JsonKey(name: 'event_id')
  final int? eventId;

  @JsonKey(name: 'event_name')
  final String? eventName;

  final String? color;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  @JsonKey(name: 'interary_pdf')
  final String? interaryPdf;

  @JsonKey(name: 'interary_text')
  final String? interaryText;

  @JsonKey(name: 'booking_pdf')
  final String? bookingPdf;

  @JsonKey(name: 'booking_text')
  final String? bookingText;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'countrie_id')
  final int? countrieId;

  final String? flag;
  final String? state;
  final String? country;

  final List<Address>? addresses;
  final List<EventBanner>? banners;

  Map<String, dynamic> toJson() => _$EventDataToJson(this);

  @override
  List<Object?> get props => [
    eventId,
    eventName,
    color,
    startDate,
    endDate,
    interaryPdf,
    interaryText,
    bookingPdf,
    bookingText,
    userId,
    countrieId,
    flag,
    state,
    country,
    addresses,
    banners,
  ];
}

@JsonSerializable()
class Address extends Equatable {
  const Address({
    this.address,
    this.longitude,
    this.latitude,
    this.destinationOverviewFreeText,
    this.interestingFactsFreeText,
    this.addpdf,
    this.primary,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final String? address;
  final String? longitude;
  final String? latitude;

  @JsonKey(name: 'destination_overview_free_text')
  final String? destinationOverviewFreeText;

  @JsonKey(name: 'interesting_facts_free_text')
  final String? interestingFactsFreeText;

  final String? addpdf;
  final int? primary;

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [
    address,
    longitude,
    latitude,
    destinationOverviewFreeText,
    interestingFactsFreeText,
    addpdf,
    primary,
  ];
}

@JsonSerializable()
class EventBanner extends Equatable {
  const EventBanner({
    this.id,
    this.bannerPath,
  });

  factory EventBanner.fromJson(Map<String, dynamic> json) =>
      _$EventBannerFromJson(json);

  final int? id;

  @JsonKey(name: 'banner_path')
  final String? bannerPath;

  Map<String, dynamic> toJson() => _$EventBannerToJson(this);

  @override
  List<Object?> get props => [id, bannerPath];
}
