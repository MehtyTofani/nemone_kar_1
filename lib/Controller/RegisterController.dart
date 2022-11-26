import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../Bloc/Blocs.dart';
import '../Helpers/BaseRequestUtil.dart';
import '../Helpers/ProjectRequestUtils.dart';
import '../Helpers/StorageUtils.dart';
import '../Helpers/ViewHelper.dart';
import '../Home/HomeScreen.dart';
import '../MainModel/UserModel.dart';

class RegisterController extends GetxController {
  ProjectRequestUtils req = ProjectRequestUtils();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  RxInt isLogin = 2.obs;
  RxInt currentPage = 0.obs;
  PageController? pageController;
  RxInt hasPass = 2.obs;
  RxBool affiliate = false.obs;

  int selectedGender = 1;

  RxBool? forgetSendCode = false.obs;

  bool fromApp = false;

  void startMobileNumber({String? mobile}) async {
    EasyLoading.show();
    ApiResult result = await this.req.startLoginRegister(
          mobileNumber: mobileController.text,
        );
    EasyLoading.dismiss();
    if (result.isDone) {
      if (result.data['is_register'] == 0) {
        this.isLogin.value = 1;
        ViewHelper.successSnackBar(
          message: 'کد تایید برای شما ارسال شد',
        );
        changePage(page: 1);
      } else {
        this.isLogin.value = 0;
        if (result.data['has_password'] == 1) {
          this.hasPass.value = 1;
        } else {
          this.hasPass.value = 0;
        }
      }
    } else {
      ViewHelper.errorSnackBar(
        message: result.data,
      );
    }
  }

  setCurrentPageController({int? page}) {
    currentPage.value = page!;
    update();
  }

  void checkOtp({String? code, bool? changePass}) async {
    EasyLoading.show();
    ApiResult result = await this.req.checkOtp(
          mobile: mobileController.text,
          code: code,
        );
    EasyLoading.dismiss();
    if (result.isDone) {
      if (changePass!) {
        forgetSendCode!.value = true;
      } else {
        changePage(page: 2);
      }
    }else{
      ViewHelper.errorSnackBar(message: result.data);
    }
  }

  void login() async {
    EasyLoading.show();
    ApiResult result = await this.req.login(
          mobile: mobileController.text,
          password: passwordController.text,
        );
    EasyLoading.dismiss();
    if (result.isDone) {
      getCustomerData();
    }else{
      ViewHelper.errorSnackBar(message: result.data);
    }
  }

  void checkAffiliate() {
    affiliate.value = !affiliate.value;
  }

  void goToHome() {
    if(fromApp){
      Get.back();
      // Get.offAll();
    }else{
      Get.off(
        HomeScreen(),
      );
    }
  }

  @override
  void onInit() {
    pageController = PageController(
      initialPage: currentPage.value,
    );
    if(Get.arguments[0] is Widget){
      fromApp = true;
    }
    super.onInit();
  }

  void changePage({int? page}) {
    pageController!.animateToPage(page!,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  // void changeGender({GenderModel? item, List<GenderModel>? list}) {
  //   list!.forEach((element) {
  //     element.isSelected!.value = false;
  //   });
  //   item!.isSelected!.value = true;
  //   selectedGender = item.id!;
  // }

  void completeRegister() async {
    if (fNameController.text != '') {
      if (lNameController.text != '') {
        if (registerPasswordController.text.isNotEmpty) {
          EasyLoading.show();
          ApiResult result = await this.req.completeRegister(
              mobile: mobileController.text,
              affiliate: (affiliate.value) ? '1' : '2',
              fName: fNameController.text,
              lName: lNameController.text,
              gender: selectedGender.toString(),
              password: registerPasswordController.text);
          // EasyLoading.dismiss();
          if (result.isDone) {
            Future.delayed(Duration(seconds: 1), () {
              getCustomerData();
            });
          }
        } else {
          ViewHelper.errorSnackBar(
            message: 'لطفا رمزعبور خود را وارد کنید',
          );
        }
      } else {
        ViewHelper.errorSnackBar(
          message: 'لطفا نام خانوادگی خود را وارد کنید',
        );
      }
    } else {
      ViewHelper.errorSnackBar(
        message: 'لطفا نام خود را وارد کنید',
      );
    }
  }

  void getCustomerData() async {
    ApiResult result =
        await this.req.getUserData(mobile: mobileController.text);
    if (result.isDone) {
      StorageUtils.setMobile(mobile: mobileController.text);
      Blocs.user.setData(UserModel.fromJson(result.data));
      EasyLoading.dismiss();
      ViewHelper.successSnackBar(
        message: 'ثبت نام شما با موفقیت انجام شد',
      );
      Future.delayed(Duration(seconds: 2), () {
        goToHome();
      });
    }
  }

  void showForgetPasswordModal() async {
    EasyLoading.show();

    ApiResult result =
        await this.req.forgetPassword(mobile: mobileController.text);
    EasyLoading.dismiss();
    if (result.isDone) {
      // showMaterialModalBottomSheet(
      //   context: Get.context!,
      //   backgroundColor: Colors.transparent,
      //   enableDrag: false,
      //   builder: (BuildContext context) => ForgetPasswordModal(),
      // );
    }
  }

  void setNewPassword() async {
    EasyLoading.show();
    ApiResult result = await this.req.setNewPassword(
          mobile: mobileController.text,
          newPassword: newPasswordController.text,
        );
    EasyLoading.dismiss();
    if (result.isDone) {
      forgetSendCode!.value = false;
      Get.back();
      ViewHelper.successSnackBar(
        message: 'رمز عبور جدید با موفقیت تغییر یافت',
      );
    }
  }
}
