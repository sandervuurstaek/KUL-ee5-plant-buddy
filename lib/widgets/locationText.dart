import 'package:flutter/cupertino.dart';
import 'package:plantbuddy/controller/location_handler.dart';
import 'package:plantbuddy/widgets/text.dart';

class LocationText extends StatefulWidget {
  final double lat, lon;
  const LocationText({Key? key,required this.lat, required this.lon}) : super(key: key);

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationText> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: LocationHandler.getCityFromCoordinates(widget.lat, widget.lon),
        builder: (context, AsyncSnapshot<String?> city)=>
        !city.hasData || city.data == null?Header3Text("..."):
            Header3Text(city.data!)
        );
  }
}
