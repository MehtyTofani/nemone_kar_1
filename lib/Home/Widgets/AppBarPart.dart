import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Bloc/Blocs.dart';
import '../../../Const/ColorUtils.dart';
import '../../../Controller/DrawerController.dart';
import '../../../Controller/HomeController.dart';
import '../../../Helpers/WidgetHelper.dart';



class AppBarPart extends StatelessWidget {

  final MyDrawerController? drawerController;
  final HomeController? homeController ;


  AppBarPart({this.drawerController , this.homeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .12,
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                bottom: Get.height * .025,
              ),
              height: Get.width * .3,
              width: Get.width * .3,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                    offset: Offset(
                      0.0,
                      3.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: WidgetHelper.createCard(
                color: Colors.white,
                radius: BorderRadius.zero,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                height: Get.height * .05,
                width: Get.width,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: Get.width * .2,
                    height: Get.width * .2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: ColorUtils.grey,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                ),),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                homeController!.showCityModal();
              },
              child: StreamBuilder(
                stream: Blocs.position.getStream,
                builder: (context, snapshot) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: Get.height * .025,
                    ),
                    height: Get.width * .3,
                    width: Get.width * .3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          (Blocs.position.city == null)?'انتخاب شهر':Blocs.position.city!.name!,
                          maxLines: 1,
                          maxFontSize: 14.0,
                          minFontSize: 10.0,
                          style: TextStyle(
                            color: ColorUtils.grey,
                            fontSize: 11.0,
                          ),
                        ),
                        Lottie.asset(
                          'assets/anims/arrowDown.json',
                          width: 25.0,
                          height: 25.0,
                        )
                      ],
                    ),
                  );
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
