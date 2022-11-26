import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Const/Consts.dart';
import '../../../Controller/HomeController.dart';
import '../Model/BannerModel.dart';


class BannerParts extends StatelessWidget {

  final HomeController? homeController;
  BannerParts({this.homeController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (_)=>Container(
        width: Get.width,
        height: Get.height * .2,
        child:(homeController!.bannerList.length > 0)? ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: homeController!.bannerList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBannerItem(item: homeController!.bannerList[index]),
        ):Container(),
      ),
    );
  }


  Widget _buildBannerItem({BannerModel? item}) {
    return InkWell(
      onTap: (){
        launch('${item!.bannerLink}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * .02,
          vertical: Get.height * .015,
        ),
        width: Get.width * .7,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radiusAll12,
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
        child: ClipRRect(
          borderRadius: radiusAll12,
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: 'assets/images/pattern.gif',
            image: item!.bannerImage!,
          ),
        ),
      ),
    );
  }
}
