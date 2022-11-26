import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Bloc/Blocs.dart';
import '../Helpers/AlertHelpre.dart';
import '../Helpers/BaseRequestUtil.dart';
import '../Helpers/ProjectRequestUtils.dart';
import '../Helpers/StorageUtils.dart';
import '../Home/HomeScreen.dart';
import '../Home/Model/BannerModel.dart';
import '../Home/Model/HomeAdModel.dart';
import '../MainModel/UserModel.dart';
import '../SelectCity/Model/CityModel.dart';
import '../SelectCity/Model/StateModel.dart';
import '../SelectCity/SelectCityScreen.dart';
import '../SubCategory/Model/CategoryModel.dart';
import '../SubCategory/SubCategoryScreen.dart';

class MyModel {
  List<HomeAdsModel> list = [];
  String? title;
  int? id;

  MyModel({required this.list, this.title, this.id});
}

class HomeController extends GetxController {
  ProjectRequestUtils req = ProjectRequestUtils();
  List<CategoryModel> mainCategoryList = [];
  List<HomeAdsModel> specialList = [];
  List<BannerModel> bannerList = [];
  RxList<List<CategoryModel>>? categoryList;


  RefreshController refreshController =
  RefreshController(initialRefresh: false);


  void onRefresh() async{
    StorageUtils.getCity().then((value) {
      if (value == null) {
        Future.delayed(Duration(seconds: 1), () {
          showCityModal();
        });
      } else {
        getBanner(
          state: StatesModel.fromJson(jsonDecode(value)['state']),
          city: CityModel.fromJson(jsonDecode(value)['city']),
        );
      }
      // }
    });
    // if failed,use refreshFailed()
  }

  void onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    //   setState(() {
    //
    //   });
    refresh();
    refreshController.loadComplete();
  }

  late List<MyModel> homeAdsList = [];
  RxBool isLoaded = false.obs;
  RxBool specialLoaded = false.obs;

  void goToPage({CategoryModel? item}) {
    Get.to(
      () => SubCategoryScreen(),
      arguments: [categoryList, item!],
    );
  }

  // void goToLoginPage() {
  //   Get.back();
  //   Get.to(
  //     () => RegisterScreen(),
  //     arguments: [
  //       HomeScreen(),
  //     ],
  //   );
  // }

  void showCityModal() {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) => SelectCityScreen(
        isProfile: false,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, true ? -1 : 1), end: Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  void onInit() {
    getMainCategory();
    StorageUtils.getCity().then((value) {
      if (value == null) {
        Future.delayed(Duration(seconds: 1), () {
          showCityModal();
        });
      } else {
        getBanner(
          state: StatesModel.fromJson(jsonDecode(value)['state']),
          city: CityModel.fromJson(jsonDecode(value)['city']),
        );
      }
    });
    super.onInit();
  }

  void getMainCategory() async {
    ApiResult apiResult = await this.req.getCategory(
          id: '-1',
        );
    if (apiResult.isDone) {
      mainCategoryList = CategoryModel.listFromJson(apiResult.data);
      categoryList = [mainCategoryList].obs;

      // StorageUtils.getCity().then((value) {
      //   if (value != null) {
      //     getBanner(
      //       state: StatesModel.fromJson(jsonDecode(value)['state']),
      //       city: CityModel.fromJson(jsonDecode(value)['city']),
      //     );
      //   }else{
      //     Future.delayed(Duration(seconds: 1), () {
      //       showCityModal();
      //     });
      //   }
      // });
    }
  }

  void getBanner({
    StatesModel? state,
    CityModel? city,
  }) async {
    bannerList.clear();
    ApiResult res = await this.req.getBanner();
    if (res.isDone) {
      bannerList = BannerModel.listFromJson(res.data);
    }
    randomSpecial(
      state: state,
      city: city,
    );
    refresh();
  }

  void randomSpecial({
    StatesModel? state,
    CityModel? city,
  }) async {
    specialList.clear();
    ApiResult apiResult = await this.req.randomSpecial(
          state: state!.stateId.toString(),
          city: city!.id.toString(),
        );

    if (apiResult.isDone) {
      specialList = HomeAdsModel.listFromJson(
        apiResult.data,
      );
      specialLoaded.value = true;
      refresh();
    }
    getHomeRandomAds(
      city: city,
      state: state,
    );
  }

  getHomeRandomAds({
    StatesModel? state,
    CityModel? city,
  }) async {
    homeAdsList.clear();
    mainCategoryList.forEach((element) async {
      Future.delayed(Duration(seconds: 1), () async {
        ApiResult result = await this.req.randomAds(
              city: city!.id.toString(),
              state: state!.stateId.toString(),
              id: element.id.toString(),
            );
        if (result.isDone) {
          homeAdsList.add(
            MyModel(
              title: element.name,
              id: element.id,
              list: HomeAdsModel.listFromJson(result.data),
            ),
          );
          refresh();
        }
      });
    });
    refreshController.refreshCompleted();
    setToStorage(
      selectedStateId: state,
      selectedCityId: city,
    );
  }

  void setToStorage({
    StatesModel? selectedStateId,
    CityModel? selectedCityId,
  }) async {
    StorageUtils.setCity(
        stateId: selectedStateId, cityId: selectedCityId, setNull: false);
    isLoaded.value = true;
    refresh();
    Get.back();
  }

  void goToSingleAd({
    HomeAdsModel? item,
    int? index,
  }) {
    // print(item!.name);
    // print(item.id);
    // print(item.image);
    // Get.to(
    //   // () => SingleAdScreen(
    //   //   title: item!.name,
    //   //   image: item.image,
    //   //   fromAffiliate: false,
    //   //   id: item.id.toString(),
    //   //   listIndex: index,
    //   // ),
    //   // arguments: [
    //   //   item!.id.toString(),
    //   // ],
    // );
  }

  void submitButtonMethod() {
    if (Blocs.user.user is UserModel) {
      if (Blocs.user.user!.stateId == 0) {
        AlertHelper.showCustomAlert(
            title:
                'برای انتشار آگهی ابتدا نیاز هست که اطلاعات پروفایل خود را تکمیل کنید',
            cancelTitle: 'بعدا',
            actionTitle: 'تکمیل پروفایل',
            actionMethod: () {
              Get.back();
              // Get.to(() => ProfileScreen());
            });
      } else {
        // Get.to(() => AddAdsScreen(), arguments: [
        //   categoryList,
        // ]);
      }
    } else {
      AlertHelper.showLoginAlert(
          title: 'برای افزودن آگهی ابتدا باید ثبت نام کنید',
          onTap: () {
            // goToLoginPage();
          });
    }
  }

  void goToSearchPage() {
    Get.toNamed(
      '/search',
      arguments: [mainCategoryList],
    );
  }
}
