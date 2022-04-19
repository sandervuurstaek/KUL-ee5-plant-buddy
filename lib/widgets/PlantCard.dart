import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/PlantInfo.dart';
import 'package:plantbuddy/widgets/text.dart';

class PlantCard extends StatelessWidget {

  final String plantName;

  const PlantCard(this.plantName,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0.25,
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage('asset/plant3.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                    child: ListTile(
                      leading:  Header3Text(
                        plantName,
                        softWrap: true,
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(72, 75, 75, 1.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const PlantInfo();
                        }));
                      },
                    )),

              ]
          ),

    );
  }
}
