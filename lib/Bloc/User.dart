import 'dart:async';
import '../MainModel/UserModel.dart';

class User {
  // ignore: close_sinks
  final streamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => streamController.stream;

  UserModel? user;

  void setData(UserModel? userData) {
    this.user = userData;
    this.streamController.sink.add(this.user);
  }

  addMobile({String? mobile}){
    this.user!.mobile = mobile;
    this.streamController.sink.add(this.user);
  }



  deleteImage(){
    this.user!.image = '';
    this.streamController.sink.add(this.user);
  }

  // void addPosition({StatesModel? state , CityModel? city}) {
  //   this.user!.stateId = state!.stateId;
  //   this.user!.cityId = city!.id;
  //   this.streamController.sink.add(this.user);
  // }
}
