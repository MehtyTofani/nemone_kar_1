import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Const/Consts.dart';


class BannerPart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .15,
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .03,
      ),
      child: ClipRRect(
        borderRadius: radiusAll12,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/banner.png',
          ),
        ),
      ),
    );
  }
}
