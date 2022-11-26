import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/HomeController.dart';
import '../../../Helpers/ViewHelper.dart';
import 'MainAdsPart.dart';

class RandomAdsWidget extends StatelessWidget {
  final HomeController? homeController;

  RandomAdsWidget({this.homeController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (_) {
        return (homeController!.isLoaded.isTrue)
            ? Container(
                width: Get.width,
                height: (homeController!.homeAdsList.length) * Get.height * .28,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeController!.homeAdsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MainAdsPart(
                      list: homeController!.homeAdsList[index].list,
                      title: homeController!.homeAdsList[index].title,
                      moreAdsId:
                          homeController!.homeAdsList[index].id.toString(),
                    );
                  },
                ),
              )
            : ViewHelper.loadingAnimation();
      },
    );
  }
}
