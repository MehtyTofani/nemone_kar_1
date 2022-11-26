import 'package:get/get.dart';
import '../Bloc/Blocs.dart';
import '../Helpers/StorageUtils.dart';
import '../Home/HomeScreen.dart';
import '../Sample11/Sample11.dart';
import '../Splash/SplashScreen.dart';

class MyDrawerController extends GetxController {


  void goToPage({String? page}){
    // Scaffold.of(Get.context!).openEndDrawer();
    Get.back();
    Get.toNamed(page!);
  }



  void exitFromAccount()async{
    Blocs.user.user = null;
    StorageUtils.setMobile(mobile: null);
    StorageUtils.setCity(stateId: null , cityId: null , setNull: true);
    Get.offAll(SplashScreen());
  }



  void goToLoginPage() {
    Get.back();
    Get.to(
          () => Sample11(),
      arguments: [
        HomeScreen(),
      ],
    );
  }

}
