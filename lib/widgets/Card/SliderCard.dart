import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/model/Sensor.dart';
import '../text.dart';

//ignore: must_be_immutable
class SliderCard extends StatefulWidget {
  final double min;
  final double max;
  final Widget leadingIcon;
  final String text;
  RangeValues selectRange =RangeValues(0.2,98);
  SliderCard({Key? key,required this.min, required this.max,required this.leadingIcon,required this.text}) : super(key: key);

  @override
  _SliderCardState createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {


  @override
  Widget build(BuildContext context) {


    return Container(
      margin:  const EdgeInsets.only(left: 16,right: 16),
      decoration: CardDecoration(16),
      child: Column(
        children: [
          SizedBox(height: 8,),
          Header3Text(widget.text,textStyle: TextStyle(color: Colors.grey),),
          ListTile(
              title: RangeSlider(
                activeColor: Sensor.getSensorColor(widget.text),
                min: widget.min,
                max: widget.max,
                divisions: 100,
                values: widget.selectRange,
                labels: RangeLabels('${widget.selectRange.start}','${widget.selectRange.end}'),
                onChanged: (RangeValues newRange){
                  setState(() {
                    widget.selectRange=newRange;
                  });
                },
              ),
              leading: widget.leadingIcon,

          ),
          SizedBox(height: 8,),
        ],
      ),

    );
  }
}
