import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

/// Storage class for weather data, can be initialised with a JSON
@JsonSerializable()
class WeatherData {
  DateTime timestamp;
  int sourceId;
  double? cloudCover;
  String condition;
  double? dewPoint;
  String icon;
  double? precipitation,
      pressureMsl,
      relativeHumidity,
      sunshine,
      temperature,
      visibility,
      windDirection,
      windSpeed,
      windGustDirection,
      windGustSpeed;

  WeatherData(
      {required this.timestamp,
      required this.sourceId,
      this.cloudCover,
      required this.condition,
      this.dewPoint,
      required this.icon,
      this.precipitation,
      this.pressureMsl,
      this.relativeHumidity,
      this.sunshine,
      this.temperature,
      this.visibility,
      this.windDirection,
      this.windGustDirection,
      this.windGustSpeed,
      this.windSpeed});

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}
