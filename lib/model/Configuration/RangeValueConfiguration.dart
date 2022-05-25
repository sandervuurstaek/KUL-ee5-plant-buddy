import 'Configuration.dart';

class RangeValueConfiguration extends Configuration{
  final double min;
  final double max;
  final int typeId;
  RangeValueConfiguration({required this.min, required this.max, required this.typeId}) : super(typeId: typeId);

  static List<RangeValueConfiguration> getConfigurations(data){
    List<RangeValueConfiguration> configurations=[];
    for(var m in data)
    {
      if(m['configuration_type']<3)
        {
          print(m['min']);
          RangeValueConfiguration configuration=RangeValueConfiguration(min: m['min'].toDouble(), typeId: m['configuration_type'], max: m['max'].toDouble());
          configurations.add(configuration);
        }
    }
    return configurations;
  }
}