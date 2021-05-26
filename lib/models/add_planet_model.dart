import 'package:flutter/foundation.dart';

class AddPlanetModel {
  dynamic float_switch, relay, soil_mosture;
  dynamic ph_reading, sensor_humidity, sensor_temperature;
  String image, name;
  dynamic key;

  AddPlanetModel({
    @required this.float_switch,
    @required this.ph_reading,
    @required this.relay,
    @required this.sensor_humidity,
    @required this.sensor_temperature,
    @required this.soil_mosture,
    @required this.image,
    @required this.name,
    @required this.key,
  });

  factory AddPlanetModel.fromMap(Map<dynamic, dynamic> map, var key) {
    return new AddPlanetModel(
      float_switch: map['float_switch'],
      ph_reading: map['ph_reading'],
      relay: map['relay'],
      sensor_humidity: map['sensor_humidity'],
      sensor_temperature: map['sensor_temperature'],
      soil_mosture: map['soil_mosture'],
      image: map['image'],
      name: map['name'],
      key: key,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'float_switch': this.float_switch,
      'ph_reading': this.ph_reading,
      'relay': this.relay,
      'sensor_humidity': this.sensor_humidity,
      'sensor_temperature': this.sensor_temperature,
      'soil_mosture': this.soil_mosture,
      'image': this.image,
      'name': this.name,
    };
  }
}
