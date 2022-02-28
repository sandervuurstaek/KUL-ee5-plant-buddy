import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:plantbuddy/models/location_handler.dart';
import 'package:plantbuddy/models/weather/weather.dart';
import 'package:plantbuddy/widgets/text.dart';

/// Card with weather information based on [lat], [lon] and [timestamp].
///
/// Will check for permisions and loads location data and weather for that date.
/// Features an animated background based on weather data.
/// If no weather data is available, it will show "Loading data...".
class WeatherCard extends StatefulWidget {
  final double lat, lon;
  final DateTime timestamp;
  late final Weather _weather;

  WeatherCard(
      {Key? key, required this.lat, required this.lon, required this.timestamp})
      : super(key: key) {
    _weather = Weather(lat: lat, lon: lon, timestamp: timestamp);
  }

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String getDayString() {
    DateTime today = DateTime.now();
    if (today.year == widget.timestamp.year &&
        today.month == widget.timestamp.month &&
        today.day == widget.timestamp.day) {
      return "Today";
    }
    return DateFormat.MMMMd().format(widget.timestamp);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle weatherCardDefaultTextStyle =
        const TextStyle(color: Colors.white);

    super.build(context);
    return FutureBuilder(
      future: LocationHandler.getCityFromCoordinates(widget.lat, widget.lon),
      builder: (context, AsyncSnapshot<String?> city) => FutureBuilder(
        future: widget._weather.getWeatherData(),
        builder: (context, AsyncSnapshot<int> weatherResult) => SizedBox(
          height: 128,
          width: double.infinity,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Stack(
                  alignment: const Alignment(0, 0),
                  children: [
                    WeatherBg(
                      weatherType: widget._weather.weatherType,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                    Container(
                      color: Colors.grey.withOpacity(.25),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Header3Text(
                                  getDayString(),
                                  textStyle: weatherCardDefaultTextStyle,
                                ),
                              ),
                              if (city.hasData && city.data != null)
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Header2Text(
                                    city.data!,
                                    textStyle: weatherCardDefaultTextStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: !widget._weather.hasData
                                  ? Header2Text("Loading data...",
                                      textStyle: weatherCardDefaultTextStyle)
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Header1Text(
                                          widget._weather.temperature
                                                  .round()
                                                  .toString() +
                                              " °C",
                                          textStyle: weatherCardDefaultTextStyle
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Header3Text(
                                                    "Wind: " +
                                                        widget
                                                            ._weather.windSpeed
                                                            .round()
                                                            .toString() +
                                                        " km/h",
                                                    textStyle:
                                                        weatherCardDefaultTextStyle),
                                                Transform.rotate(
                                                  angle: widget._weather
                                                          .windDirection *
                                                      math.pi /
                                                      180,
                                                  child: const Icon(
                                                      Icons.arrow_upward,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Header3Text(
                                                    "Clouds: " +
                                                        widget
                                                            ._weather.windSpeed
                                                            .round()
                                                            .toString() +
                                                        " %",
                                                    textStyle:
                                                        weatherCardDefaultTextStyle),
                                              ],
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
