import 'package:plantbuddy/model/Configuration/Configuration.dart';

class SingleValueConfiguration extends Configuration{
  final double min;
  final int typeId;
  SingleValueConfiguration({required this.min, required this.typeId}) : super(typeId: typeId);

  static List<SingleValueConfiguration> getConfigurations(data){
    List<SingleValueConfiguration> configurations=[];
    for(var m in data)
    {
      if(m['configuration_type']>=3)
        {
          SingleValueConfiguration configuration=SingleValueConfiguration(min: m['min'].toDouble(), typeId: m['configuration_type']);
          configurations.add(configuration);
        }
    }
    return configurations;
  }
}