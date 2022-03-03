import 'package:json_annotation/json_annotation.dart';

part 'weather_source.g.dart';

@JsonSerializable()
class WeatherSource {
  int id;
  String? dwdStationId, wmoStationId, stationName;
  String observationType;
  DateTime firstRecord, lastRecord;
  double lat, lon, height, distance;

  WeatherSource(
      {required this.id,
      this.dwdStationId,
      this.wmoStationId,
      this.stationName,
      required this.observationType,
      required this.firstRecord,
      required this.lastRecord,
      required this.lat,
      required this.lon,
      required this.height,
      required this.distance});

  factory WeatherSource.fromJson(Map<String, dynamic> json) =>
      _$WeatherSourceFromJson(json);
}
