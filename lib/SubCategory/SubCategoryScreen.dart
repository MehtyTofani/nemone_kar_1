import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Const/ColorUtils.dart';
import '../Const/Consts.dart';
import '../Helpers/ViewHelper.dart';
import 'Controller/CategoryController.dart';
import 'Model/CategoryModel.dart';

class SubCategoryScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final int index = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Container(
                margin: ViewHelper.screenPadding(),
                height: double.maxFinite,
                width: Get.width,
                child: Column(
                  children: [
                    _buildBannerPart(),
                    _buildCategoryList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerPart() {
    return GetBuilder(
      init: CategoryController(),
      builder: (_) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * .03,
        ),
        width: Get.width,
        height: Get.height * .18,
        decoration: BoxDecoration(
          boxShadow: ViewHelper.shadow(),
          borderRadius: radiusAll10,
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: ClipRRect(
                borderRadius: radiusAll10,
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/pattern.gif',
                  image: categoryController.model.last.banner!,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: Get.height * .02,
                ),
                padding: paddingSymmetricH8,
                width: Get.width,
                height: Get.height * .04,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorUtils.grey,
                      ColorUtils.grey.withOpacity(.7),
                      ColorUtils.grey.withOpacity(.4),
                      ColorUtils.grey.withOpacity(.1),
                      Colors.transparent,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    categoryController.model.last.name!,
                    maxFontSize: 16.0,
                    minFontSize: 12.0,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      width: Get.width,
      height: Get.height * .09,
      decoration: BoxDecoration(
        boxShadow: ViewHelper.shadow(),
        color: ColorUtils.main,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            GetBuilder(
              init: CategoryController(),
              builder: (_) => Center(
                child: AutoSizeText(
                  categoryController.model.last.name!,
                  maxLines: 1,
                  maxFontSize: 20.0,
                  minFontSize: 12.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  categoryController.previousList();
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Expanded(
      child: Container(
        height: Get.height,
        width: Get.width,
        margin: EdgeInsets.only(
          top: Get.height * .02,
        ),
        child: Obx(
          () => (categoryController.categoryList.length == 1)
              ? Center(
                  child: ViewHelper.loadingAnimation(),
                )
              : ListView.builder(
                  itemCount: categoryController.categoryList.last.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      _buildCategoryItem(
                    item: categoryController.categoryList.last[index],
                    index: index,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem({CategoryModel? item, int? index}) {
    return GestureDetector(
      onTap: () {
        if (item!.hasSub!) {
          categoryController.getMainCategory(item: item);
        } else {
          // categoryController.goToAdsList(item: item, index: index);
        }
      },
      child: Container(
        width: Get.width,
        height: Get.height * .08,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * .01,
          horizontal: Get.width * .04,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ViewHelper.shadow(),
          borderRadius: radiusAll16,
        ),
        child: Row(
          children: [
            _buildItemImage(image: item!.banner , index:index),
            _buildItemTitle(title: item.name),
            _buildItemArrow(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemImage({String? image , int? index,}) {
    return Flexible(
      flex: 2,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: Hero(
          tag: 'image-$index',
          child: ClipRRect(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(16.0)),
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                image!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemTitle({String? title}) {
    return Flexible(
      flex: 4,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .03,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: AutoSizeText(
            title!,
            maxFontSize: 18.0,
            minFontSize: 14.0,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16.0,
              color: ColorUtils.textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemArrow() {
    return Flexible(
      flex: 1,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: ColorUtils.green,
          ),
        ),
      ),
    );
  }
}
