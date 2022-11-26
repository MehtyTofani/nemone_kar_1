import 'package:auto_size_text_pk/auto_size_text_pk.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Const/ColorUtils.dart';
import '../../Controller/DrawerController.dart';
import '../../Controller/HomeController.dart';
import '../../Drawer/Drawer.dart';
import '../../Helpers/AlertHelpre.dart';

import 'Widgets/AddAdButtonWidget.dart';
import 'Widgets/AppBarPart.dart';
import 'Widgets/BannerPart.dart';
import 'Widgets/BannersPart.dart';
import 'Widgets/MainAdsPart.dart';
import 'Widgets/MainCategoryPart.dart';
import 'Widgets/RandomAdsWidget.dart';
import 'Widgets/SearchBoxPart.dart';
import 'Widgets/SpecialPart.dart';

class HomeScreen extends StatelessWidget {
  final MyDrawerController drawerController = Get.put(MyDrawerController());
  final HomeController homeController = Get.put(HomeController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AlertHelper.showCustomAlert(
            title: 'برای خروج از برنامه مطمئنید؟',
            cancelTitle: 'لغو',
            actionTitle: 'خروج',
            actionMethod: () {
              SystemNavigator.pop();
            });
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder(
          init: this.homeController,
          builder: (_) => Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            drawer: DrawerScreen(),
            body: SafeArea(
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    AppBarPart(
                      drawerController: drawerController,
                      homeController: homeController,
                    ),
                    Expanded(
                      child: Container(
                        height: double.maxFinite,
                        width: Get.width,
                        child: SmartRefresher(
                          header: WaterDropHeader(
                            waterDropColor: ColorUtils.main,
                            complete: Lottie.asset('assets/anims/success.json'),
                            completeDuration: Duration(milliseconds: 1500),
                          ),
                          controller: homeController.refreshController,
                          onRefresh: homeController.onRefresh,
                          onLoading: homeController.onLoading,
                          child: Column(
                            children: [
                              BannerPart(),
                              SizedBox(
                                height: Get.height * .02,
                              ),
                              SearchBoxPart(
                                homeController: homeController,
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              _buildMainBody(),
                            ],
                          ),
                        ),
                      ),
                    )
                    // _buildAddAdButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainBody() {
    return Expanded(
      child: Container(
        width: Get.width,
        height: double.maxFinite,
        child: Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    MainCategoryPart(
                      homeController: this.homeController,
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    BannerParts(
                      homeController: this.homeController,
                    ),
                    SpecialPart(
                      homeController: homeController,
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    RandomAdsWidget(
                      homeController: homeController,
                    ),
                    SizedBox(
                      height: Get.height * .07,
                    ),
                  ],
                ),
              ),
            ),
            AddAdButtonWidget(
              homeController: homeController,
            )
          ],
        ),
      ),
    );
  }
}
