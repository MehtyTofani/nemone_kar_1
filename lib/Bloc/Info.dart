import 'dart:async';
import '../MainModel/AboutUsModel.dart';

class Info {
  // ignore: close_sinks
  final streamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => streamController.stream;

  AboutUsModel? info;

  void setData({AboutUsModel? aboutUs}) {
    this.info = aboutUs;
    this.streamController.sink.add(this.info);
  }
// void addPosition({StatesModel? state , CityModel? city}) {
//   this.user!.stateId = state!.stateId;
//   this.user!.cityId = city!.id;
//   this.streamController.sink.add(this.user);
// }
}
