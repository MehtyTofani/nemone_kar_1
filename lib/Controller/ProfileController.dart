import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/Blocs.dart';
import '../Helpers/BaseRequestUtil.dart';
import '../Helpers/ProjectRequestUtils.dart';
import '../Helpers/ViewHelper.dart';
import '../MainModel/UserModel.dart';
import '../SelectCity/Model/CityModel.dart';
import '../SelectCity/Model/StateModel.dart';
import '../SelectCity/SelectCityScreen.dart';

class ProfileController extends GetxController {
  ProjectRequestUtils req = ProjectRequestUtils();

  // List<GenderModel> genderList = [
  //   GenderModel(id: 1, title: 'مرد', isSelected: false.obs),
  //   GenderModel(id: 2, title: 'زن', isSelected: false.obs),
  // ];

  RxBool affiliate = false.obs;

  StatesModel? state;
  CityModel? city;

  bool hasSetState = false;

  int selectedGender = 1;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController telegramController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController webSiteController = TextEditingController();

  XFile? profileImage;
  final ImagePicker _picker = ImagePicker();

  Future pickImage({ImageSource? source}) async {
    Get.back();
    _picker.pickImage(source: source!).then((value) {
      profileImage = value;
      print(profileImage!.path);
    });
  }

  // void changeGender({GenderModel? item, List<GenderModel>? list}) {
  //   list!.forEach((element) {
  //     element.isSelected!.value = false;
  //   });
  //   item!.isSelected!.value = true;
  //   selectedGender = item.id!;
  // }

  // void showPickerImageAlert({bool? video}) {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: Get.context!,
  //     builder: (_) => Directionality(
  //       textDirection: TextDirection.rtl,
  //       child: AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         scrollable: true,
  //         backgroundColor: Colors.transparent,
  //         elevation: 50.0,
  //         content: SelectSourceImagePickerAlert(
  //           cameraFunc: () {
  //             cameraPick(
  //               video: video,
  //             );
  //           },
  //           galleryFunc: () {
  //             galleryPick(
  //               video: video,
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future cameraPick({bool? video}) async {
    Get.back();
    _picker.pickImage(source: ImageSource.camera).then((value) {
      profileImage = value;
      print(profileImage!.path);
      refresh();
    });
  }

  Future galleryPick({bool? video}) async {
    Get.back();
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      profileImage = value;
      print(profileImage!.path);
      refresh();
    });
  }

  // void setProfileData() {
  //   firstNameController.text = Blocs.user.user!.firstName!;
  //   print(Blocs.user.user!.firstName!);
  //   lastNameController.text = Blocs.user.user!.lastName!;
  //   genderList.forEach((element) {
  //     if (element.id == Blocs.user.user!.gender) {
  //       element.isSelected = true.obs;
  //     }
  //   });
  //
  //   affiliate.value = Blocs.user.user!.cooperation == 1;
  //   emailController.text = (Blocs.user.user!.social!.email == null)
  //       ? ''
  //       : Blocs.user.user!.social!.email!;
  //   instagramController.text = (Blocs.user.user!.social!.instagram == null)
  //       ? ''
  //       : Blocs.user.user!.social!.instagram!;
  //   telegramController.text = (Blocs.user.user!.social!.telegram == null)
  //       ? ''
  //       : Blocs.user.user!.social!.telegram!;
  //   webSiteController.text = (Blocs.user.user!.social!.website == null)
  //       ? ''
  //       : Blocs.user.user!.social!.website!;
  //   refresh();
  //   getStateData();
  // }

  void showCityModal({ProfileController? controller}) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) =>
          SelectCityScreen(isProfile: true, controller: controller),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, true ? -1 : 1), end: Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  void setPositionData({StatesModel? myState, CityModel? myCity}) async {
    // StorageUtils.setProfileCity(
    //   stateId: myState,
    //   cityId: myCity,
    // );
    state = myState;
    city = myCity;
    update();
    Get.back();
  }

  void showEditProfilePic() {
    // showMaterialModalBottomSheet(
    //   context: Get.context!,
    //   builder: (BuildContext context) => EditProfileImage(
    //     editFunc: () {
    //       Get.back();
    //       this.showPickerImageAlert(
    //         video: false,
    //       );
    //     },
    //     deleteFunc: () {
    //       AlertHelper.showCustomAlert(
    //           title: 'برای حذف عکس پروفایل خود مطمئنید؟',
    //           cancelTitle: 'لغو',
    //           actionTitle: 'حذف',
    //           actionMethod: () {
    //             this.removeProfilePicture();
    //           });
    //     },
    //   ),
    // );
  }

  void checkAffiliate() {
    affiliate.value = !affiliate.value;
  }

  void saveChanges() async {
    EasyLoading.show();
    ApiResult result = await this.req.saveChangesData(
          fName: firstNameController.text,
          lName: lastNameController.text,
          cityId: city!.id.toString(),
          email: emailController.text,
          stateId: state!.stateId.toString(),
          image: (profileImage is XFile)
              ? base64Encode(
                  File(profileImage!.path).readAsBytesSync(),
                )
              : '',
          gender: selectedGender.toString(),
          cooperation: (affiliate.value) ? '1' : '2',
          instagram: instagramController.text,
          telegram: telegramController.text,
          webSite: webSiteController.text,
        );
    if (result.isDone) {
      ViewHelper.successSnackBar(
        message: result.data,
      );
      getNewData();
    } else {
      EasyLoading.dismiss();
      ViewHelper.errorSnackBar(message: result.data);
    }
  }

  getNewData() async {
    ApiResult result = await this.req.getUserData(
          mobile: Blocs.user.user!.mobile,
        );
    EasyLoading.dismiss();
    if (result.isDone) {
      Blocs.user.setData(UserModel.fromJson(result.data));
      // Future.delayed(Duration(seconds: 3), () {
      //   Get.back();
      // });
    }
  }

  void removeProfilePicture() async {
    EasyLoading.show();

    ApiResult result = await this.req.deleteProfileImage();
    EasyLoading.dismiss();
    if (result.isDone) {
      if(profileImage is XFile){
        profileImage = null;
      }else{
        Blocs.user.deleteImage();
      }
      getNewData();
      Get.back();
      Get.back();
      ViewHelper.successSnackBar(
        message: 'عکس پروفایل با موفقیت حذف شد',
      );
    } else {
      ViewHelper.errorSnackBar(
        message: 'خطایی رخ داد',
      );
    }

    profileImage = null;
    Blocs.user.user!.image = '';
    Get.back();
    refresh();
  }

  getStateData() async {
    if (Blocs.user.user is UserModel) {
      if (Blocs.user.user!.stateId == 0) {
        this.hasSetState = false;
      } else {
        state = StatesModel(
            stateId: Blocs.user.user!.stateId,
            isSelected: true,
            stateName: Blocs.user.user!.stateName);
        city = CityModel(
            id: Blocs.user.user!.cityId,
            name: Blocs.user.user!.cityName,);
        city!.isSelected = true;
        this.hasSetState = true;
      }
    }
    update();
  }

  @override
  void onInit() {
    print(Blocs.user.user);
    if (Blocs.user.user is UserModel) {
      // setProfileData();
    }
    super.onInit();
  }

  void backToHome() {
    state = StatesModel(
      stateId: Blocs.user.user!.stateId,
      isSelected: true,
      stateName: Blocs.user.user!.stateName,
    );
    city = CityModel(
        id: Blocs.user.user!.cityId,
        name: Blocs.user.user!.cityName);
    city!.isSelected = true;
  }
}
