import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../Const/ColorUtils.dart';
import '../Const/Consts.dart';

class AlertHelper {
  static void showLoginAlert({
    String? title,
    GestureTapCallback? onTap,
  }) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.all(8.0),
            // margin: EdgeInsets.symmetric(
            //   horizontal: size.width * .05,
            // ),
            width: Get.width,
            height: Get.height * .38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: radiusAll10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset(
                  'assets/anims/loginAlert.json',
                  fit: BoxFit.cover,
                  height: Get.width * .4,
                  width: Get.width * .4,
                ),
                AutoSizeText(
                  title!,
                  maxFontSize: 18.0,
                  maxLines: 2,
                  minFontSize: 10.0,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: Get.width,
                    height: Get.height * .05,
                    decoration: BoxDecoration(
                      borderRadius: radiusAll8,
                      color: ColorUtils.main,
                    ),
                    child: Center(
                      child: AutoSizeText(
                        'ورود به حساب کاربری',
                        maxLines: 1,
                        maxFontSize: 20.0,
                        minFontSize: 12.0,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // static void paymentStatus(
  //     {bool? success, Function? successFunc, Function? failedFunc}) {
  //   showDialog(
  //     context: Get.context!,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) => AlertDialog(
  //       backgroundColor: Colors.transparent,
  //       contentPadding: EdgeInsets.zero,
  //       content: PaymentStatusAlert(
  //         failedFunc: failedFunc,
  //         successFunc: successFunc,
  //         success: success,
  //       ),
  //     ),
  //   );
  // }

  static void showCustomAlert({
    String? title,
    String? actionTitle,
    String? cancelTitle,
    GestureTapCallback? actionMethod,
  }) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.all(8.0),
            // margin: EdgeInsets.symmetric(
            //   horizontal: size.width * .05,
            // ),
            width: Get.width,
            height: Get.height * .3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: radiusAll10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset(
                  'assets/anims/loginAlert.json',
                  fit: BoxFit.cover,
                  height: Get.width * .2,
                  width: Get.width * .2,
                ),
                AutoSizeText(
                  title!,
                  maxFontSize: 18.0,
                  maxLines: 2,
                  minFontSize: 10.0,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                GestureDetector(
                  onTap: actionMethod,
                  child: Container(
                    width: Get.width,
                    height: Get.height * .05,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: radiusAll8,
                              color: ColorUtils.main,
                            ),
                            child: Center(
                              child: AutoSizeText(
                                actionTitle!,
                                maxLines: 1,
                                maxFontSize: 20.0,
                                minFontSize: 12.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * .05,
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: AutoSizeText(
                                  cancelTitle!,
                                  style: TextStyle(
                                    color: ColorUtils.textColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
