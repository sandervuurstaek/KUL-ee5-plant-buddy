


class Data {
  final String timeStamp;
  final double value;
  final String type;
  late DateTime date;
  Data({required this.timeStamp, required this.value, required this.type}){
    date= DateTime.parse(timeStamp);
  }
}