import 'dart:convert';
import 'package:get/get.dart';
import '../Bloc/Blocs.dart';
import '../Helpers/BaseRequestUtil.dart';
import '../Helpers/ProjectRequestUtils.dart';
import '../Helpers/StorageUtils.dart';
import '../Home/HomeScreen.dart';
import '../MainModel/AboutUsModel.dart';
import '../MainModel/UserModel.dart';
import '../SelectCity/Model/CityModel.dart';
import '../SelectCity/Model/StateModel.dart';

class SplashController extends GetxController {
  ProjectRequestUtils req = ProjectRequestUtils();

  void timer() {
    StorageUtils.getMobile().then((value) {
      if (value != null) {
        getUserData(
          mobile: value,
        );
      }
    });
  }

  getUserData({String? mobile}) async {
    ApiResult result = await this.req.getUserData(mobile: mobile);
    if (result.isDone) {
      Blocs.user.setData(UserModel.fromJson(result.data));
    }
  }

  @override
  void onInit() {
    getInfoData();
    super.onInit();
  }

  getInfoData() async {
    ApiResult result = await this.req.aboutUsInfo();
    if (result.isDone) {
      Blocs.info.setData(
        aboutUs: AboutUsModel.fromJson(result.data[0]),
      );
    }

    getCity();
  }

  void getCity() async {
    StorageUtils.getCity().then((value) {
      if (value == null) {
        Future.delayed(Duration(seconds: 5), () {
          Get.off(
            HomeScreen(),
          );
        });
      } else {
        timer();
        Blocs.position.addPosition(
          myCity: CityModel.fromJson(jsonDecode(value)['city']),
          myState: StatesModel.fromJson(jsonDecode(value)['state']),
        );
        Future.delayed(Duration(seconds: 5), () {
          Get.off(
            // IntroScreen()
            HomeScreen(),
          );
        });
      }
    });
  }
}
