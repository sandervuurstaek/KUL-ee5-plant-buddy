class Message {
  final int id;
  final int type;
  late final String notification;
  final String plantName;
  final String timeStamp;
  late final DateTime date;
   Message({required this.id, required this.type, required this.plantName, required this.timeStamp}){
    notification=_getNotificationType(type);
    date= DateTime.parse(timeStamp);
  }


   String _getNotificationType(int typeId){
    String type;
    switch(typeId){
      case 1: {
        type="white led broken";
      }
      break;

      case 2 : {
        type="blue led broken";
      }
      break;

      case 3: {
        type="red led broken";
      }
      break;

      case 4 :{
        type="far red led broken";
      }
      break;

      case 5 :{
        type="environmental sensor broken";
      }
      break;

      case 6: {
        type="moisture too low (plant needs water)";
      }
      break;

      case 7: {
        type="water level too low (reservoir needs to be refilled)";
      }
      break;

      case 8: {
        type="water pump broken";
      }
      break;
      case 9: {
        type="led cooling fan broken";
      }
      break;

      default: {
        type="UnKnown";
      }
    }
    return type;
  }
}