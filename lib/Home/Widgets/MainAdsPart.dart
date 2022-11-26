import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Const/ColorUtils.dart';
import '../../../Const/Consts.dart';
import '../../../Helpers/ViewHelper.dart';
import '../Model/HomeAdModel.dart';

class MainAdsPart extends StatelessWidget {
  String? title;
  String? moreAdsId;
  List<HomeAdsModel> list;

  MainAdsPart({this.title, this.moreAdsId, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .28,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: Get.width,
              height: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * .03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.rotate(
                        angle: 2.35,
                        child: Container(
                          height: Get.width * .03,
                          width: Get.width * .03,
                          decoration: BoxDecoration(
                            color: ColorUtils.mainDote,
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * .03,
                      ),
                      AutoSizeText(
                        title!,
                        style: TextStyle(
                          color: ColorUtils.textColor,
                        ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/singleCategoryScreen', arguments: [
                        moreAdsId,
                        title,
                      ]);
                    },
                    child: AutoSizeText(
                      'نمایش همه',
                      maxFontSize: 16.0,
                      minFontSize: 10.0,
                      maxLines: 1,
                      style: TextStyle(
                        color: ColorUtils.mainDote,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Container(
              width: Get.width,
              height: double.maxFinite,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) =>
                    _buildMainAdsItem(
                  item: list[index],
                  index: index,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainAdsItem({
    HomeAdsModel? item,
    int? index,
  }) {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //   () => SingleAdScreen(
        //     image: item!.image,
        //     id: item.id.toString(),
        //     title: item.name,
        //     fromAffiliate: false,
        //     listIndex: index,
        //   ),
        //   arguments: [item!.id.toString()],
        // );
      },
      child: Container(
        height: Get.height,
        width: Get.width * .35,
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * .02,
          vertical: Get.height * .01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radiusAll24,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(
                0.0,
                2.0,
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
                child: Center(
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
                        image: item!.image!,
                      ),
                    ),
                  ),
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
                              color: Colors.black,
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
                      child: Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: (item.price == '')
                            ? Center(
                              child: AutoSizeText(
                                  'رایگان',
                                  maxFontSize: 16.0,
                                  minFontSize: 8.0,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: ColorUtils.textColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                            )
                            : Row(
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
                              ),
                      ),
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
}
