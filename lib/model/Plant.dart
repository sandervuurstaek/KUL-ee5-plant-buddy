
import 'dart:typed_data';

class Plant {
 final int PlantID;
  String PlantName;
 final Uint8List? pict;
 final String api_key;
 final String device_identifier;

  Plant({required this.PlantID, required this.PlantName,this.pict,required this.api_key, required this.device_identifier});

}