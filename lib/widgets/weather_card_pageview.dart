import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:plantbuddy/controller/location_handler.dart';
import 'package:plantbuddy/widgets/adaptive_widget.dart';
import 'package:plantbuddy/widgets/custom_scroll_behaviour.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/widgets/weather_card.dart';

/// Pageview with WeatherCards to show the weather for multiple days.
///
/// [days] specify the amount of days starting from today, should be at least 1.
class WeatherCardPageView extends StatelessWidget {
  final double? height;
  final int days;
  late final PageController _pageController;

  WeatherCardPageView({
    Key? key,
    this.height,
    required this.days,
  }) : super(key: key) {
    _pageController = PageController(
      viewportFraction: 0.9,
      keepPage: true,
    );
    {
      assert(days >= 1, "Cannot show less than 1 day");
    }
  }

  Widget _weatherCardBuilder(
      BuildContext context, int index, AsyncSnapshot<LocationData?> location) {
    // If date is today, use current time. Today is index 0
    DateTime now = DateTime.now();
    DateTime date = index == 0
        ? now
        : DateTime.utc(now.year, now.month, now.day + index, 12);

    return WeatherCard(
      lat: location.data!.latitude ?? 0,
      lon: location.data!.longitude ?? 0,
      timestamp: date,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocationHandler.getCurrentLocation(),
      builder: (context, AsyncSnapshot<LocationData?> location) =>
          !location.hasData
              ? Center(child: Header3Text("Loading weather..."))
              : location.data == null
                  ? Header3Text("Error loading weather")
                  : AdaptiveWidget(
                      context: context,
                      xsmallWidget: SizedBox(
                        height: height,
                        child: PageView.builder(
                          scrollBehavior: const CustomScrollBehaviour(),
                          controller: _pageController,
                          itemCount: days,
                          itemBuilder: (context, index) =>
                              _weatherCardBuilder(context, index, location),
                        ),
                      ),
                      mediumWidget: SizedBox(
                        height: height != null ? height! * days : null,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: days,
                          itemBuilder: (context, index) =>
                              _weatherCardBuilder(context, index, location),
                        ),
                      ),
                    ),
    );
  }
}
