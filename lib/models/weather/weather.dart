import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:plantbuddy/models/location_handler.dart';
import 'package:plantbuddy/models/rest_request.dart';
import 'package:plantbuddy/models/weather/weather_data.dart';
import 'package:plantbuddy/models/weather/weather_source.dart';

/// All possible 'icon' responses to map to icons
enum WeatherIcon {
  noIcon,
  clearDay,
  clearNight,
  partlyCloudyDay,
  partlyCloudyNight,
  cloudy,
  fog,
  wind,
  rain,
  sleet,
  snow,
  hail,
  thunderstorm,
}

/// Used to get weather data
class Weather extends RestRequest {
  final double lat, lon;
  DateTime timestamp;
  WeatherData? _weatherData;
  WeatherSource? _weatherSource;
  String? _city;

  int? requestResponseCode;

  Weather({required this.lat, required this.lon, required this.timestamp})
      : super(baseUrl: "api.brightsky.dev");

  Future<int> getWeatherData() async {
    // Api docs: https://brightsky.dev/docs/
    return super.httpGet(
      "/weather",
      queryParameters: {
        "lat": lat.toString(),
        "lon": lon.toString(),
        "date": timestamp.toIso8601String(),
      },
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    ).then((response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        _weatherData = WeatherData.fromJson(json["weather"][0]);
        _weatherSource = WeatherSource.fromJson(json["sources"][0]);
        _city = await LocationHandler.getCityFromCoordinates(
            _weatherSource!.lat, _weatherSource!.lon);
      }

      return response.statusCode;
    });
  }

  bool get hasData => (_weatherData != null && _weatherSource != null);

  String get city => _city ?? "No city found";

  double get temperature => (hasData && _weatherData!.temperature != null)
      ? _weatherData!.temperature!
      : double.nan;

  double get windDirection => (hasData && _weatherData!.windDirection != null)
      ? _weatherData!.windDirection!
      : double.nan;

  double get windSpeed => (hasData && _weatherData!.windSpeed != null)
      ? _weatherData!.windSpeed!
      : double.nan;

  WeatherIcon getWeatherIcon() {
    if (_weatherData == null) {
      print("icon is null");
      return WeatherIcon.noIcon;
    }

    print(_weatherData!.icon);

    switch (_weatherData!.icon) {
      case "clear-day":
        return WeatherIcon.clearDay;

      case "clear-night":
        return WeatherIcon.clearNight;

      case "partly-cloudy-day":
        return WeatherIcon.partlyCloudyDay;

      case "partly-cloudy-night":
        return WeatherIcon.partlyCloudyNight;

      case "fog":
        return WeatherIcon.fog;

      case "wind":
        return WeatherIcon.wind;

      case "rain":
        return WeatherIcon.rain;

      case "sleet":
        return WeatherIcon.sleet;

      case "snow":
        return WeatherIcon.snow;

      case "hail":
        return WeatherIcon.hail;

      case "thunderstorm":
        return WeatherIcon.thunderstorm;

      default:
        return WeatherIcon.noIcon;
    }
  }

  WeatherType get weatherType {
    switch (getWeatherIcon()) {
      case WeatherIcon.clearDay:
        return WeatherType.sunny;

      case WeatherIcon.clearNight:
        return WeatherType.sunnyNight;

      case WeatherIcon.partlyCloudyDay:
        return WeatherType.overcast;

      case WeatherIcon.partlyCloudyNight:
        return WeatherType.cloudyNight;

      case WeatherIcon.cloudy:
        return WeatherType.cloudy;

      case WeatherIcon.fog:
      case WeatherIcon.sleet:
        return WeatherType.foggy;

      case WeatherIcon.wind:
        return WeatherType.dusty;

      case WeatherIcon.rain:
        return WeatherType.middleRainy;

      case WeatherIcon.snow:
        return WeatherType.middleSnow;

      case WeatherIcon.hail:
        return WeatherType.heavyRainy;

      case WeatherIcon.thunderstorm:
        return WeatherType.thunder;

      case WeatherIcon.noIcon:
      default:
        return WeatherType.sunny;
    }
  }
}
