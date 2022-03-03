// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      timestamp: DateTime.parse(json['timestamp'] as String),
      sourceId: json['source_id'] as int,
      cloudCover: (json['cloud_cover'] as num?)?.toDouble(),
      condition: json['condition'] as String,
      dewPoint: (json['dew_point'] as num?)?.toDouble(),
      icon: json['icon'] as String,
      precipitation: (json['precipitation'] as num?)?.toDouble(),
      pressureMsl: (json['pressure_msl'] as num?)?.toDouble(),
      relativeHumidity: (json['relative_humidity'] as num?)?.toDouble(),
      sunshine: (json['sunshine'] as num?)?.toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      visibility: (json['visibility'] as num?)?.toDouble(),
      windDirection: (json['wind_direction'] as num?)?.toDouble(),
      windGustDirection: (json['wind_gust_direction'] as num?)?.toDouble(),
      windGustSpeed: (json['wind_gust_speed'] as num?)?.toDouble(),
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    );
