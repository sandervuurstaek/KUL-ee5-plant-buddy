
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/model/Sensor.dart';
import '../../model/Data.dart';
import '../../widgets/DataCard/DataChartCard.dart';
import '../../widgets/transparant_appbar.dart';



class PlantDataPage extends StatefulWidget {
  final List<Data> data;
  final String sensorType;
   const PlantDataPage({Key? key, required this.data, required this.sensorType}) : super(key: key);
  @override
  _PlantDataPageState createState() => _PlantDataPageState();
}

class _PlantDataPageState extends State<PlantDataPage> {
  DateTime selectedDate =DateTime.now();

  Data? _getMax(List<Data> data)
  {
    if(data.isEmpty)
    {
      return null;
    }
    return data.reduce((max, element) {
      if(max.value >= element.value){
        return max;
      } else {
        return element;
      }
    });
  }

  Data? _getMin(List<Data> data)
  {
    if(data.isEmpty)
      {
        return null;
      }
    return data.reduce((min, element) {
      if(min.value < element.value){
        return min;
      } else {
        return element;
      }
    });
  }

  Data? _getLatest(List<Data> data){
    if(data.isEmpty)
    {
      return null;
    }
    return data.reduce((lastest, element){
      if(lastest.date.millisecondsSinceEpoch>=element.date.millisecondsSinceEpoch)
        {
          return lastest;
        }
      else{
        return element;
      }
    });
  }

  double? _getAvg(List<Data> data){
    if(data.isEmpty)
    {
      return null;
    }
    var sum= data.map((e) => e.value).reduce((sum, element){
      return sum+element;
    });
    return sum/data.length;
  }




  Widget _avg(List<Data> filteredData){
    return Container(
      height: 120,
      decoration: CardDecoration(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Header3Text("Average",textStyle: TextStyle(fontWeight: FontWeight.bold,color: Sensor.getSensorColor(widget.sensorType)),),
          !filteredData.isEmpty?Header3Text("${_getAvg(filteredData)?.toStringAsFixed(2)}${Sensor.getSensorUnit(widget.sensorType)}")
              :Header3Text('______',textStyle: TextStyle(color: Colors.grey)),
          Header6Text("          "),
        ],
      ),

    );
  }

  String? _getTime(String? timeStamp, bool withDay){
    if(withDay)
      {
        return timeStamp;
      }
    return timeStamp?.substring(10);
  }




  Widget _min(List<Data> filteredData){
    return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(4),
      height: 120,
      decoration: CardDecoration(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Header3Text("Min",textStyle: TextStyle(fontWeight: FontWeight.bold,color: Sensor.getSensorColor(widget.sensorType)),),
          !filteredData.isEmpty?Header3Text("${_getMin(filteredData)?.value.toString()}${Sensor.getSensorUnit(widget.sensorType)}"):
              Header3Text("______",textStyle: TextStyle(color: Colors.grey)),
          !filteredData.isEmpty?Header6Text(_getTime(_getMin(filteredData)?.timeStamp.toString(),false),textStyle: TextStyle(color: Colors.grey,),textAlign: TextAlign.center,)
              : Header3Text("______",textStyle: TextStyle(color: Colors.grey))
        ],
      )

    );
  }

  Widget _max(List<Data> filteredData){
    return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(4),
        height: 120,
        decoration: CardDecoration(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Header3Text("Max",textStyle: TextStyle(fontWeight: FontWeight.bold,color: Sensor.getSensorColor(widget.sensorType)),),
            !filteredData.isEmpty?Header3Text("${_getMax(filteredData)?.value.toString()}${Sensor.getSensorUnit(widget.sensorType)}")
                :Header3Text("______",textStyle: TextStyle(color: Colors.grey)),
            !filteredData.isEmpty?Header6Text(_getTime(_getMax(filteredData)?.timeStamp.toString(),false),textStyle: TextStyle(color: Colors.grey),):
            Header3Text("______",textStyle: TextStyle(color: Colors.grey)),
          ],
        )

    );
  }

  Widget _latest(){
  return  Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      decoration: CardDecoration(16),
      child: Column(
        children: [
          Header3Text("Latest",textStyle: TextStyle(fontWeight: FontWeight.bold,color: Sensor.getSensorColor(widget.sensorType)),),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !widget.data.isEmpty?Header3Text("${_getLatest(widget.data)?.value.toString()}${Sensor.getSensorUnit(widget.sensorType)}"):
              Header5Text("no data",textStyle: TextStyle(color: Colors.grey)),
              SizedBox(width: 20,),
              !widget.data.isEmpty?Header5Text(_getTime(_getLatest(widget.data)?.timeStamp.toString(), true),textStyle: TextStyle(color: Colors.grey),):
              Header5Text("",textStyle: TextStyle(color: Colors.grey)),
            ],
          )
        ],

      ),
    );
  }

  _selectDate(BuildContext context)async {
    final DateTime? date =await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100),
      builder: (context,child){
          return Theme(
              data: ThemeData().copyWith(colorScheme: ColorScheme.light(
                primary: Sensor.getSensorColor(widget.sensorType),
              )),
              child: child!);
      },
      selectableDayPredicate: (date){
          return date.difference(DateTime.now()).inMilliseconds<0;
             }
       );
      setState(() {
        selectedDate=date!;
      });
  }


  @override
  Widget build(BuildContext context) {
    List<Data> filteredData=widget.data.where((element) {
      if(element.date.year==selectedDate.year && element.date.month==selectedDate.month && element.date.day==selectedDate.day)
      {
        return true;
      }
      else{
        return false;
      }
    }).toList();

    Widget history=Container(margin: EdgeInsets.all(8),child: Header5Text("${selectedDate.toString().substring(0,10)}",textStyle: TextStyle(color: Colors.grey),));

    Widget dataAnalysisArea=Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(flex:1,child: _min(filteredData)),
        Expanded(flex:1,child: _avg(filteredData)),
        Expanded(flex:1,child: _max(filteredData))
    ],);

    Widget HeaderArea=Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(2),
      decoration: CardDecoration(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Sensor.getSensorIcon(widget.sensorType, 48),
          Header3Text(widget.sensorType,textStyle: TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    );



    Widget selectTime= Container(
      margin: EdgeInsets.all(8),
      child: TextInButton(data: "Select Date", pressed: ()=>_selectDate(context),color: Sensor.getSensorColor(widget.sensorType),)
        ,decoration: CardDecoration(16),);



    return Scaffold(
      appBar: const TransparantAppbar(
        title: '',
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 710),
          child:  Scrollbar(
              child:  ListView(
                children: [

                  SizedBox(height: 10),
                  HeaderArea,
                  _latest(),
                  selectTime,
                  history,
                  dataAnalysisArea,
                  DataChart(data: filteredData,date: selectedDate,sensorType: widget.sensorType,),
                  SizedBox(height: 80,)
                ],
              ),

            ),

        ),
      ),

    );
  }
}
