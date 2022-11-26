import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_formatter/money_formatter.dart';

import '../Const/ColorUtils.dart';

class ViewHelper {
  static void onChange({String? string,
    TextEditingController? textEditingController,
    Function? func}) {
    func!();
    List<String> list = string!.split('');
    if (list.length > 0) {
      switch (list.length) {
        case 1:
          if (list[0] == '0') {
            textEditingController!.text = '0';
          } else {
            textEditingController!.clear();
          }
          break;
        case 2:
          if (list[1] == '9') {
            textEditingController!.text = '09';
          } else {
            textEditingController!.text = '0';
          }

          break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
          list.removeAt(0);
          list.removeAt(0);
          textEditingController!.text = '09' + list.join('');
          break;
      }
      Future.delayed(
        Duration.zero,
            () =>
        textEditingController!.selection = TextSelection.fromPosition(
          TextPosition(
            offset: textEditingController.text.length,
          ),
        ),
      );
    }
  }

  static String moneyFormat(double price) {
    return MoneyFormatter(amount: price).output.withoutFractionDigits;
  }

  static List<BoxShadow> shadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(.3),
        blurRadius: 5.0,
        spreadRadius: 3.0,
        offset: Offset(
          0.0,
          3.0,
        ),
      ),
    ];
  }

  static EdgeInsets screenPadding() {
    return EdgeInsets.symmetric(
      horizontal: Get.width * .025,
      vertical: Get.height * .01,
    );
  }

  static void errorSnackBar({String? message}) {
    Get.snackbar(
      'خطا',
      message!,
      isDismissible: true,
      barBlur: 10.0,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.clear,
        color: Colors.white,
        size: 30.0,
      ),
      backgroundColor: Colors.red.withOpacity(.3),
      boxShadows: ViewHelper.shadow(),
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .03,
        horizontal: Get.width * .02,
      ),
    );
  }

  static void successSnackBar({String? message}) {
    Get.snackbar(
      'موفقیت',
      message!,
      isDismissible: true,
      barBlur: 10.0,
      colorText: Colors.white,
      icon: Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 30.0,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorUtils.green.withOpacity(.3),
      boxShadows: ViewHelper.shadow(),
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .03,
        horizontal: Get.width * .02,
      ),
      shouldIconPulse: true,
      duration: Duration(seconds: 2),
    );
  }

  static showEmptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/anims/emptyList.json',
          height: Get.width * .5,
          width: Get.width * .5,
        ),
        AutoSizeText(
          'داده ای وجود ندارد',
          maxLines: 1,
          maxFontSize: 16.0,
          minFontSize: 10.0,
          style: TextStyle(
            color: ColorUtils.textColor,
            fontSize: 12.0,
          ),
        )
      ],
    );
  }

  static loadingAnimation() {
    return Center(
      child: Lottie.asset('assets/anims/loadingList.json' ,
        height: Get.width * .2,
        repeat: true,
        width: Get.width * .2,
      ),
    );
  }
}
