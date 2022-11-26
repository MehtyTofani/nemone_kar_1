import 'dart:convert';
import 'dart:ffi';
import '../SelectCity/Model/CityModel.dart';
import '../SelectCity/Model/StateModel.dart';
import 'Storage.dart';



class StorageUtils{
  static Future<void> setMobile({String? mobile})async{
    await MyStorage.set(name: 'mobile' , value: mobile );
  }

  static Future<dynamic> getMobile()async{
    return MyStorage.getString(name: 'mobile');
  }

  static Future<void> setCity({StatesModel? stateId , CityModel? cityId , bool? setNull})async{
    Map data = {
      'state': stateId,
      'city':cityId,
    };
    if(setNull!){
      await MyStorage.set(name: 'position' , value: null );
    }else{
      await MyStorage.set(name: 'position' , value: jsonEncode(data) );
    }
  }

  static Future<void> setProfileCity({StatesModel? stateId , CityModel? cityId})async{
    Map data = {
      'state': stateId,
      'city':cityId,
    };
    await MyStorage.set(name: 'profilePosition' , value: jsonEncode(data) );
  }

  static Future<dynamic> getProfileCity()async{
    return MyStorage.getString(name: 'profilePosition');
  }

  static Future<dynamic> getCity()async{
    return MyStorage.getString(name: 'position');
  }



}