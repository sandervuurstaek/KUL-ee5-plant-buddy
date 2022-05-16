import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/myPlants/PlantInfo.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../../model/Plant.dart';

class PlantCard extends StatelessWidget {

  final Plant plant;
  const PlantCard(this.plant,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(6),
      decoration: CardDecoration(16),
      child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
               Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage('asset/defaultPlantPhoto.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                Expanded(
                    child: ListTile(
                      leading:  Header3Text(
                        plant.PlantName,
                        softWrap: true,
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(72, 75, 75, 1.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return PlantInfo(plant: plant,);
                        }));
                      },
                    )),

              ]
          ),

    );
  }
}
