class Configuration {
   late final String type;
   final int typeId;
   Configuration({ required this.typeId}){
     type=getConfigurationType(typeId);
   }

  static String getConfigurationType(int configurationId){
    String configurationType;
    switch(configurationId){
      case 1: {
        configurationType="LDR";
      }
      break;

      case 2 : {
        configurationType="Moisture";
      }
      break;

      case 3: {
        configurationType="LED_white";
      }
      break;

      case 4 :{
        configurationType="LED_blue";
      }
      break;

      case 5 :{
        configurationType="LED_hyper_red";
      }
      break;

      case 6: {
        configurationType="LED_far_red";
      }
      break;

      default: {
        configurationType="UnKnown";
      }
    }

    return configurationType;
  }



  static int getConfigurationID(String type)
  {
    int ID;
    switch(type){

      case "LDR" :{
        ID=1;
      }
      break;


      case "Moisture": {
        ID=2;
      }
      break;

      case "LED_white":{
        ID=3;
      }
      break;
      case "LED_blue":{
        ID=4;
      }
      break;
      case "LED_hyper_red":{
        ID=5;
      }
      break;
      case "LED_far_red":{
        ID=6;
      }
      break;

      default: {
        ID=0;
      }
    }

    return ID;
  }

}