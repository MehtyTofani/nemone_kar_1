import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'Controller/Sample4Controller.dart';
import 'Model/Sample4Model.dart';

class Sample4 extends StatelessWidget {
  final Sample4Controller myAdsController = Get.put(Sample4Controller());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Center(
            child: Column(
              children: const [
                Text("MyAdsScreen"),
                // WidgetHelper.singleAppBar(
                //   title: 'آگهی های من',
                // ),
                // Expanded(
                //   child: Container(
                //     width: Get.width,
                //     height: double.maxFinite,
                //     padding: ViewHelper.screenPadding(),
                //     child: Obx(
                //       () => (myAdsController.isLoaded.value)
                //           ? (myAdsController.listCount.value == 0)
                //               ? ViewHelper.showEmptyList()
                //               : Column(
                //                   children: [
                //                     Expanded(
                //                       child: Container(
                //                         height: double.maxFinite,
                //                         width: Get.width,
                //                         child: GridView.builder(
                //                           shrinkWrap: true,
                //                           controller:
                //                               myAdsController.scrollController,
                //                           physics: BouncingScrollPhysics(),
                //                           gridDelegate:
                //                               SliverGridDelegateWithFixedCrossAxisCount(
                //                             crossAxisCount: 2,
                //                             crossAxisSpacing: 1,
                //                             mainAxisSpacing: 12,
                //                             childAspectRatio: .6,
                //                           ),
                //                           itemBuilder: (_, index) =>
                //                               _buildSpecialItem(
                //                                   item: myAdsController
                //                                       .myAdsList[index]),
                //                           itemCount:
                //                               myAdsController.myAdsList.length,
                //                         ),
                //                       ),
                //                     ),
                //                     Obx(
                //                       () =>
                //                           (myAdsController.isRefreshLoaded.value)
                //                               ? Column(
                //                                   children: [
                //                                     SizedBox(
                //                                       height: Get.height * .05,
                //                                     ),
                //                                     Container(
                //                                       width: Get.width * .1,
                //                                       height: Get.width * .1,
                //                                       child:
                //                                           CircularProgressIndicator(),
                //                                     ),
                //                                   ],
                //                                 )
                //                               : Container(),
                //                     )
                //                   ],
                //                 )
                //           : ViewHelper.loadingAnimation(),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildSpecialItem({MyAdsModel? item}) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(
  //       horizontal: Get.width * .01,
  //       vertical: Get.height * .01,
  //     ),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: radiusAll24,
  //       boxShadow: ViewHelper.shadow(),
  //     ),
  //     child: Column(
  //       children: [
  //         _buildImage(
  //           item: item,
  //         ),
  //         _buildAdDetail(
  //           item: item,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildImage({MyAdsModel? item}) {
  //   Color? bannerColor = Color(0xFFD08FF5).withOpacity(.85);
  //
  //   String status = '';
  //
  //   switch (item!.status) {
  //     case 0:
  //       {
  //         status = 'در انتظار تایید';
  //         break;
  //       }
  //     case 1:
  //       {
  //         status = 'تایید شده';
  //         bannerColor = ColorUtils.editGreen.withOpacity(.85);
  //         break;
  //       }
  //     case 2:
  //       {
  //         status = 'رد شده';
  //         bannerColor = ColorUtils.red.withOpacity(.85);
  //         break;
  //       }
  //     default:
  //       {
  //         status = 'منقضی شده';
  //         bannerColor = ColorUtils.main.withOpacity(.85);
  //         break;
  //       }
  //   }
  //
  //   return Flexible(
  //     flex: 2,
  //     child: Container(
  //       height: double.maxFinite,
  //       width: double.maxFinite,
  //       child: Stack(
  //         children: [
  //           Container(
  //             height: double.maxFinite,
  //             width: double.maxFinite,
  //             child: ClipRRect(
  //               borderRadius: radiusAll24,
  //               child: FadeInImage.assetNetwork(
  //                 fit: BoxFit.cover,
  //                 height: double.maxFinite,
  //                 width: double.maxFinite,
  //                 placeholder: 'assets/images/pattern.gif',
  //                 image: item.image!,
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             top: Get.height * .025,
  //             right: -Get.width * .06,
  //             child: Transform.rotate(
  //               angle: .75,
  //               child: Container(
  //                 width: Get.width * .3,
  //                 height: Get.height * .03,
  //                 color: bannerColor,
  //                 child: Center(
  //                   // alignment: Alignment.centerRight,
  //                   child: AutoSizeText(
  //                     status,
  //                     maxFontSize: 14.0,
  //                     minFontSize: 10.0,
  //                     maxLines: 1,
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 12.0,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildAdDetail({MyAdsModel? item}) {
  //   Widget? priceTypeWidget;
  //
  //   switch (item!.priceTypeId) {
  //     case 1:
  //       {
  //         priceTypeWidget = AutoSizeText(
  //           'توافقی',
  //           maxFontSize: 16.0,
  //           minFontSize: 8.0,
  //           maxLines: 1,
  //           style: TextStyle(
  //             color: ColorUtils.textColor,
  //             fontSize: 12.0,
  //           ),
  //         );
  //         break;
  //       }
  //     case 2:
  //       {
  //         priceTypeWidget = AutoSizeText(
  //           'رایگان',
  //           maxFontSize: 16.0,
  //           minFontSize: 8.0,
  //           maxLines: 1,
  //           style: TextStyle(
  //             color: ColorUtils.textColor,
  //             fontSize: 12.0,
  //           ),
  //         );
  //         break;
  //       }
  //     case 3:
  //       {
  //         priceTypeWidget = AutoSizeText(
  //           'معاوضه',
  //           maxFontSize: 16.0,
  //           minFontSize: 8.0,
  //           maxLines: 1,
  //           style: TextStyle(
  //             color: ColorUtils.textColor,
  //             fontSize: 12.0,
  //           ),
  //         );
  //         break;
  //       }
  //     case 4:
  //       {
  //         priceTypeWidget = Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             AutoSizeText(
  //               ViewHelper.moneyFormat(
  //                 double.parse(
  //                   item.price!.replaceAll(',', ''),
  //                 ),
  //               ),
  //               maxFontSize: 16.0,
  //               minFontSize: 8.0,
  //               maxLines: 2,
  //               style: TextStyle(
  //                 color: ColorUtils.textColor,
  //                 fontSize: 12.0,
  //               ),
  //             ),
  //             SizedBox(
  //               width: Get.width * .01,
  //             ),
  //             AutoSizeText(
  //               'تومان',
  //               maxFontSize: 14.0,
  //               minFontSize: 8.0,
  //               maxLines: 1,
  //               style: TextStyle(
  //                 color: Colors.grey,
  //                 fontSize: 10.0,
  //               ),
  //             ),
  //           ],
  //         );
  //         break;
  //       }
  //   }
  //   return Flexible(
  //     flex: 1,
  //     child: Container(
  //       height: double.maxFinite,
  //       width: double.maxFinite,
  //       padding: EdgeInsets.symmetric(
  //         horizontal: Get.width * .02,
  //       ),
  //       child: Column(
  //         children: [
  //           Flexible(
  //             flex: 1,
  //             child: Container(
  //               height: double.maxFinite,
  //               width: double.maxFinite,
  //               child: Row(
  //                 children: [
  //                   SvgPicture.asset(
  //                     'assets/images/svg/PetFoot.svg',
  //                     height: Get.width * .06,
  //                     width: Get.width * .06,
  //                   ),
  //                   SizedBox(
  //                     width: Get.width * .02,
  //                   ),
  //                   Expanded(
  //                     child: Container(
  //                       width: double.maxFinite,
  //                       height: double.maxFinite,
  //                       child: Center(
  //                         child: AutoSizeText(
  //                           item.name!,
  //                           maxFontSize: 16.0,
  //                           minFontSize: 8.0,
  //                           maxLines: 2,
  //                           style: TextStyle(
  //                             color: Colors.black45,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: Get.height * .002,
  //           ),
  //           Flexible(
  //             flex: 1,
  //             child: Container(
  //               height: double.maxFinite,
  //               width: double.maxFinite,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: Container(
  //                       height: double.maxFinite,
  //                       width: double.maxFinite,
  //                       child: Center(child: priceTypeWidget!),
  //                     ),
  //                   ),
  //                   _buildEditButton(item: item),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildEditButton({MyAdsModel? item}) {
  //   return InkWell(
  //     onTap: () {
  //       myAdsController.goToEditAdd(item: item);
  //     },
  //     child: Container(
  //       width: Get.width * .1,
  //       height: Get.width * .1,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: ColorUtils.editGreen,
  //         boxShadow: ViewHelper.shadow(),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             Icons.edit_outlined,
  //             color: Colors.white,
  //             size: 16.0,
  //           ),
  //           AutoSizeText(
  //             'ویرایش',
  //             maxFontSize: 10.0,
  //             minFontSize: 6.0,
  //             maxLines: 1,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 8.0,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
