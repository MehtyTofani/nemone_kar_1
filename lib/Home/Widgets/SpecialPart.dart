import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Const/ColorUtils.dart';
import '../../Const/Consts.dart';
import '../../Controller/HomeController.dart';
import '../../Helpers/ViewHelper.dart';
import '../Model/HomeAdModel.dart';

class SpecialPart extends StatelessWidget {
  final HomeController? homeController;

  SpecialPart({this.homeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .25,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .01,
      ),
      child: GetBuilder(
        init: HomeController(),
        builder: (_) => (homeController!.specialLoaded.value)
            ? (homeController!.specialList.length != 0)
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController!.specialList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _buildSpecialItem(
                      item: homeController!.specialList[index],
                      index: index,
                    ),
                  )
                : Center(
                    child: AutoSizeText('آگهی ویژه ای وجود ندارد'),
                  )
            : ViewHelper.loadingAnimation(),
      ),
    );
  }

  Widget _buildSpecialItem({HomeAdsModel? item, int? index}) {
    Widget? priceTypeWidget;

    switch (item!.priceTypeId) {
      case 1:
        {
          priceTypeWidget = AutoSizeText(
            'توافقی',
            maxFontSize: 16.0,
            minFontSize: 8.0,
            maxLines: 1,
            style: TextStyle(
              color: ColorUtils.textColor,
              fontSize: 12.0,
            ),
          );
          break;
        }
      case 2:
        {
          priceTypeWidget = AutoSizeText(
            'رایگان',
            maxFontSize: 16.0,
            minFontSize: 8.0,
            maxLines: 1,
            style: TextStyle(
              color: ColorUtils.textColor,
              fontSize: 12.0,
            ),
          );
          break;
        }
      case 3:
        {
          priceTypeWidget = AutoSizeText(
            'معاوضه',
            maxFontSize: 16.0,
            minFontSize: 8.0,
            maxLines: 1,
            style: TextStyle(
              color: ColorUtils.textColor,
              fontSize: 12.0,
            ),
          );
          break;
        }
      case 4:
        {
          priceTypeWidget = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                ViewHelper.moneyFormat(
                  double.parse(item.price!),
                ),
                maxFontSize: 16.0,
                minFontSize: 8.0,
                maxLines: 1,
                style: TextStyle(
                  color: ColorUtils.textColor,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                width: Get.width * .01,
              ),
              AutoSizeText(
                'تومان',
                maxFontSize: 14.0,
                minFontSize: 8.0,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                ),
              ),
            ],
          );
          break;
        }
    }

    return GestureDetector(
      onTap: () {
        homeController!.goToSingleAd(
          item: item,
          index: index,
        );
      },
      child: Container(
        height: Get.height,
        width: Get.width * .35,
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * .02,
          vertical: Get.height * .015,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radiusAll24,
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
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: radiusAll24,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 5.0,
                              spreadRadius: 3.0,
                              offset: Offset(
                                0.0,
                                3.0,
                              ),
                            ),
                          ],
                        ),
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: ClipRRect(
                          borderRadius: radiusAll24,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/pattern.gif',
                            image: item.image!,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: Get.height * .03,
                        ),
                        width: Get.width,
                        height: Get.height * .025,
                        decoration: BoxDecoration(
                          color: ColorUtils.red.withOpacity(.8),
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'ویــژه',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildDatePart(
                      item: item,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: Center(
                          child: AutoSizeText(
                            item.name!,
                            maxFontSize: 16.0,
                            minFontSize: 8.0,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .002,
                    ),
                    Flexible(
                      flex: 1,
                      child: priceTypeWidget!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePart({
    HomeAdsModel? item,
  }) {
    DateTime dateTimeFromTmeStamp =
        DateTime.fromMillisecondsSinceEpoch(int.parse(item!.date!) * 1000);
    int? dateDistance;
    DateTime date = DateTime.now();
    dateDistance = date.day - dateTimeFromTmeStamp.day;
    // if (dateDistance < 0) {
    //   dateDistance = dateDistance * -1;
    // }

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 8.0,
          left: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              blurRadius: 5.0,
              spreadRadius: 3.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            ),
          ],
          borderRadius: radiusAll8,
        ),
        width: Get.width * .15,
        height: Get.height * .022,
        child: (dateDistance == 0)
            ? Center(
                child: AutoSizeText(
                  'امروز',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: ColorUtils.red,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    dateDistance.toString(),
                    maxFontSize: 14.0,
                    minFontSize: 10.0,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: ColorUtils.red,
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  AutoSizeText(
                    'روز پیش',
                    maxLines: 1,
                    maxFontSize: 12.0,
                    minFontSize: 8.0,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
