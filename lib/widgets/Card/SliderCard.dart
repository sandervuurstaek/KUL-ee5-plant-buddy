import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';

import '../text.dart';

class SliderCard extends StatefulWidget {
  double min;
  double max;
  Widget leadingIcon;
  String text;
  var selectRange =RangeValues(0.2,98);
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
             // trailing: Icon(Icons.water_drop, color: Colors.blueAccent,),

          ),
          SizedBox(height: 8,),
        ],
      ),

    );
  }
}
