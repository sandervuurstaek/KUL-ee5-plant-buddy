// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherSource _$WeatherSourceFromJson(Map<String, dynamic> json) =>
    WeatherSource(
      id: json['id'] as int,
      dwdStationId: json['dwd_station_id'] as String?,
      wmoStationId: json['wmo_station_id'] as String?,
      stationName: json['station_name'] as String?,
      observationType: json['observation_type'] as String,
      firstRecord: DateTime.parse(json['first_record'] as String),
      lastRecord: DateTime.parse(json['last_record'] as String),
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
    );
