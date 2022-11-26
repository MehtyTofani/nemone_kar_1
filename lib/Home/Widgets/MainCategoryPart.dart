import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';

import '../../../Const/ColorUtils.dart';
import '../../../Const/Consts.dart';
import '../../../Controller/HomeController.dart';
import '../../../SubCategory/Model/CategoryModel.dart';

class MainCategoryPart extends StatelessWidget {
  final HomeController? homeController;


  MainCategoryPart({this.homeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * .04,
        // vertical: Get.height * .005,
      ),
      width: Get.width,
      height: Get.height * .058,
      child: Obx(
        () => (homeController!.isLoaded.value)
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeController!.mainCategoryList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    _buildCategoryItem(
                  item: homeController!.mainCategoryList[index],
                ),
              )
            : Container(
                height: double.maxFinite,
                width: Get.width,
                child: Row(
                  children: [
                    _buildShimmer(),
                    SizedBox(
                      width: Get.width * .03,
                    ),
                    _buildShimmer(),
                    SizedBox(
                      width: Get.width * .03,
                    ),
                    _buildShimmer(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildCategoryItem({
    CategoryModel? item,
  }) {
    return InkWell(
      onTap: () {
        homeController!.goToPage(
          item: item,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * .01,
          vertical: Get.height * .003,
        ),
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .02,
        ),
        decoration: BoxDecoration(
          borderRadius: radiusAll12,
          border: Border.all(
            color: ColorUtils.green,
            width: .7,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              item!.name!,
              maxLines: 1,
              maxFontSize: 18.0,
              minFontSize: 12.0,
              style: TextStyle(
                color: ColorUtils.textColor,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              width: Get.width * .01,
            ),
            Padding(
              padding: EdgeInsets.all(
                Get.width * .02,
              ),
              child: Image(
                // height: Get.width * .13,
                // width: Get.width * .13,
                image: NetworkImage(
                  item.icon!,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radiusAll8,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.25),
                spreadRadius: 1,
                blurRadius: 5.0,
                offset: Offset(
                  0.0,
                  3.0,
                ),
              )
            ]),
        child: ClipRRect(
          borderRadius: radiusAll8,
          child: Shimmer.fromColors(
            period: Duration(seconds: 4),
            baseColor: Colors.white,
            highlightColor: Colors.grey.withOpacity(.5),
            child: Container(
              height: Get.height * .058,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: radiusAll8,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
