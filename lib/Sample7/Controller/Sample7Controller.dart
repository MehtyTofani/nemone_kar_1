import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sample7Controller extends GetxController {

  //
  // List<MyAdsModel> myAdsList = [];
  //
  // RxBool isLoaded = false.obs;
  // RxInt listCount = 0.obs;
  //
  // int page = 1;
  //
  // ScrollController? scrollController;
  //
  // RxBool isRefreshLoaded = false.obs;
  // bool hastNext = false;
  //
  //
  //
  //
  // void getMyAds() async {
  //   ApiResult result = await this.req.getMyAds(
  //         page: page.toString(),
  //       );
  //   if (result.isDone) {
  //     this.myAdsList = MyAdsModel.listFromJson(result.data['list']).obs;
  //     this.isLoaded.value = true;
  //     listCount.value = myAdsList.length;
  //     page++ ;
  //     hastNext = result.data['hasNext'];
  //   } else {
  //     ViewHelper.errorSnackBar(message: result.data);
  //   }
  // }
  //
  //
  //
  // void getNextMyAds() async {
  //   isRefreshLoaded.value = true;
  //   ApiResult result = await this.req.getMyAds(
  //     page: page.toString(),
  //   );
  //   isRefreshLoaded.value = false;
  //   if (result.isDone) {
  //     myAdsList.addAll(MyAdsMode.listFromJson(result.data['list']).obs);
  //     listCount.value = myAdsList.length;
  //     page = page + 1 ;
  //     hastNext = result.data['hasNext'];
  //   } else {
  //     ViewHelper.errorSnackBar(message: result.data);
  //   }
  // }
  //
  // @override
  // void onInit() {
  //   getMyAds();
  //
  //   scrollController = ScrollController(initialScrollOffset: 0.0);
  //   scrollController!.addListener(_scrollListener);
  //   super.onInit();
  // }
  //
  //
  //
  // _scrollListener() {
  //   if (scrollController!.offset >=
  //       scrollController!.position.maxScrollExtent &&
  //       !scrollController!.position.outOfRange) {
  //     if (hastNext) {
  //       getNextMyAds();
  //     }
  //   }
  // }
  //
  // void goToEditAdd({MyAdsModel? item}) {
  //   Get.to(() => EditAdScreen(), arguments: [
  //     item!.id.toString(),
  //   ]);
  // }
}
