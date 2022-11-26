import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;
import '../Const/ColorUtils.dart';
import '../Controller/SplashController.dart';
import '../Helpers/WidgetHelper.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          color: ColorUtils.splash,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: WidgetHelper.startTopPart(
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/svg/splashLogo.svg',
                  height: Get.width * .5,
                  width: Get.width * .5,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * .25,
                  ),
                  child: Lottie.asset(
                    'assets/anims/loading.json',
                    width: Get.width * .3,
                    height: Get.width * .3,
                    repeat: true,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Get.width * .02,
                    ),
                    child: Lottie.asset(
                      'assets/anims/loading2.json',
                      width: Get.width * .3,
                      height: Get.width * .3,
                      repeat: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
