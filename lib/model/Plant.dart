
import 'dart:typed_data';

class Plant {
  int PlantID;
  String PlantName;
  Uint8List? pict;
  String? api_key;

  Map<int,String> sensors={1:"temperature",
                           2:"pressure",
                           3:"IAQ",
                           4:"LDR",
                           5:"water_level",
                           6: "moisture",
                           7: " humidity"};

  Plant({required this.PlantID, required this.PlantName,this.pict,this.api_key});




}