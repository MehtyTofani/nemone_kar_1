import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/HomeController.dart';
import '../../../Const/ColorUtils.dart';
import '../../../Const/Consts.dart';
import '../../../Controller/HomeController.dart';
import '../../../Helpers/WidgetHelper.dart';


class AddAdButtonWidget extends StatelessWidget {
  final HomeController? homeController;


  AddAdButtonWidget({this.homeController});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width,
        height: Get.height * .07,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(.7),
              Colors.white.withOpacity(.5),
              Colors.white.withOpacity(.3),
              Colors.white.withOpacity(.1),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: _buildAddAdButton(),
        ),
      ),
    );
  }


  Widget _buildAddAdButton() {
    return WidgetHelper.createCard(
      color: ColorUtils.main,
      width: Get.width,
      onTap: () {
        homeController!.submitButtonMethod();
      },
      height: Get.height * .05,
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .15,
        vertical: Get.height * .01,
      ),
      radius: radiusAll10,
      child: Center(
        child: AutoSizeText(
          'افزودن آگهی',
          maxLines: 1,
          maxFontSize: 20.0,
          minFontSize: 12.0,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
