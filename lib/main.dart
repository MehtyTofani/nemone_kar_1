import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'Const/ColorUtils.dart';
import 'Helpers/BaseRequestUtil.dart';
import 'MainModel/GetRouts.dart';

void main() async {
  RequestsUtil.baseRequestUrl = 'http://new.louneh.louneh.com';
  RequestsUtil.token = 'test';

  await GetStorage.init();
  // SharedPreferences.setMockInitialValues({});
  runApp(
    RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
      footerBuilder:  () => ClassicFooter(),        // Configure default bottom indicator
      headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
      springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
      maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
      maxUnderScrollExtent:0, // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true,
      child: GetMaterialApp(
        localizationsDelegates: [
          RefreshLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        getPages: PageRout.pages,
        initialRoute: NameRouts.splashScreen,
        theme: ThemeData(
          fontFamily: 'iranSanc',
        ),
        builder: EasyLoading.init(),
      ),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorSize = 100.0
    ..fontSize = 18.0
    ..progressColor = ColorUtils.splash
    ..backgroundColor = Colors.transparent
    ..indicatorColor = ColorUtils.splash
    ..textColor = Colors.white
  // ..maskColor = Colors.blue
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true
    ..dismissOnTap = true;
}
