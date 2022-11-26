import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Const/ColorUtils.dart';
import '../../Const/Consts.dart';
import '../../Controller/HomeController.dart';

class SearchBoxPart extends StatelessWidget {
  final HomeController? homeController;
  SearchBoxPart({this.homeController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        homeController!.goToSearchPage();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * .05,
        ),
        height: Get.height * .05,
        width: Get.width,
        padding: paddingSymmetricH16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radiusAll10,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              'جست و جو',
              maxLines: 1,
              maxFontSize: 14.0,
              minFontSize: 10.0,
              style: TextStyle(
                color: ColorUtils.textColor,
                fontSize: 12.0,
              ),
            ),
            Icon(
              Icons.search,
              color: ColorUtils.textColor,
            )
          ],
        ),
        // child: WidgetHelper.textFormField(
        //   height: Get.height * .05,
        //   width: Get.width,
        //   prefixWidget: Icon(
        //     Icons.search,
        //     size: 28.0,
        //     color: ColorUtils.green,
        //   ),
        //   inputAction: TextInputAction.search,
        //   maxLines: 1,
        //   fillColor: Colors.white,
        //   // borderColor: ColorUtils.grey,
        //   label: 'جستجو در حیوانات، لوازم و ....',
        //   enable: false,
        //   autoFocus: false,
        //   numeric: false,
        //   hintSize: 12.0,
        //   textAlign: TextAlign.center,
        //   controller: homeController!.searchController,
        //   textStyle: TextStyle(
        //     color: ColorUtils.grey,
        //     fontSize: 16.0,
        //   ),
        //   focusedColor: ColorUtils.red,
        // ),
      ),
    );
  }
}
