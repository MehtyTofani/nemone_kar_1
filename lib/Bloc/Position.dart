import 'dart:async';
import '../SelectCity/Model/CityModel.dart';
import '../SelectCity/Model/StateModel.dart';

class Position {
  // ignore: close_sinks
  final streamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => streamController.stream;

  CityModel? city;
  StatesModel? state;

  addPosition({
    CityModel? myCity,
    StatesModel? myState,
  }) {
    this.city = myCity;
    this.state = myState;
    this.streamController.sink.add(this.city);
    this.streamController.sink.add(this.state);
  }
}
