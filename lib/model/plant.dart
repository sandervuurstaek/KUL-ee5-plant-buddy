
class Plant {
  String _PlantName;
  String _PlantType;

  Plant(this._PlantName, this._PlantType);

  String get PlantName => _PlantName;

  set PlantName(String value) {
    _PlantName = value;
  }

  String get PlantType => _PlantType;

  set PlantType(String value) {
    _PlantType = value;
  }
}