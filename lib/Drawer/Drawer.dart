import 'dart:io';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nemone_kar1/Sample9/Sample9.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Bloc/Blocs.dart';
import '../Const/ColorUtils.dart';
import '../Const/Consts.dart';
import '../Controller/DrawerController.dart';
import '../Helpers/AlertHelpre.dart';
import '../Helpers/IconHelper.dart';
import '../Helpers/ViewHelper.dart';
import '../Helpers/WidgetHelper.dart';
import '../MainModel/GetRouts.dart';
import '../MainModel/UserModel.dart';
import '../Sample8/Sample8.dart';
import 'Widgets/DrawerProfilePart.dart';

class DrawerScreen extends StatelessWidget {
  MyDrawerController drawerController = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
        elevation: 100.0,
        child: Padding(
          padding: paddingAll6,
          child: Center(
            child: this.listCard(),
          ),
        ),
      ),
    );
  }

  Widget listCard() {
    return Container(
      width: Get.width,
      height: Get.height * .9,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.75),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(46.0),
          right: Radius.zero,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            offset: Offset(-25, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          DrawerProfilePart(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * .05,
            ),
            child: Divider(
              color: ColorUtils.main,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 8.0,
                  ),
                  height: double.maxFinite,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        WidgetHelper.menuItem(
                          icon: IconHelpers.exit,
                          title: AutoSizeText(
                            (Blocs.user.user is UserModel)
                                ? "خروج از حساب کاربری"
                                : "ورود به حساب کاربری",
                            style: TextStyle(
                              color: (Blocs.user.user is UserModel)
                                  ? ColorUtils.red
                                  : ColorUtils.editGreen,
                            ),
                          ),
                          onTap: () async {
                            // Blocs.user.sync();
                            if (Blocs.user.user is UserModel) {
                              AlertHelper.showCustomAlert(
                                actionMethod: () {
                                  drawerController.exitFromAccount();
                                },
                                actionTitle: 'خروج',
                                cancelTitle: 'لغو',
                                title: 'برای خروج مطمئنید؟',
                              );
                            } else {
                              drawerController.goToLoginPage();
                            }
                            // if (Platform.isAndroid) {
                            //   SystemChannels.platform
                            //       .invokeMethod('SystemNavigator.pop');
                            // } else {
                            //   // MinimizeApp.minimizeApp();
                            // }
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.myAds,
                          title: AutoSizeText(
                            "آگهی های من",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            if (Blocs.user.user is UserModel) {
                              drawerController.goToPage(
                                page: NameRouts.myAds,
                              );
                            } else {
                              AlertHelper.showLoginAlert(
                                  title:
                                      'برای مشاهده لیست آگهی های خود ابتدا باید وارد حساب کاربری خود شوید',
                                  onTap: () {
                                    Get.back();
                                    drawerController.goToLoginPage();
                                  });
                            }
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.affiliate,
                          title: AutoSizeText(
                            "همکاری در فروش",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            if (Blocs.user.user!.cooperation == 2) {
                              ViewHelper.errorSnackBar(
                                message:
                                    'اگر قصد همکاری در فروش را دارید ابتدا از بخش پروفایل این امکان را برای خود فعال سازید',
                              );
                            } else {
                              drawerController.goToPage(
                                page: NameRouts.sample1,
                              );
                            }
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.club,
                          title: AutoSizeText(
                            "باشگاه مشتریان",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            if (Blocs.user.user!.mobile! is String) {
                              drawerController.goToPage(
                                page: NameRouts.sample2,
                              );
                            } else {
                              // AlertHelper.showLoginAlert(
                              //   context: context,
                              //   size: size,
                              //   title:
                              //       'برای مشاهده لیست آدرس ها ابتدا باید وارد حساب کاربری خود شوید',
                              //   page: RegisterScreen(
                              //     page: HomeScreen(),
                              //   ),
                              // );
                            }
                          },
                        ),
                        WidgetHelper.menuItem(
                            icon: IconHelpers.match,
                            title: AutoSizeText(
                              "مسابقه",
                              style: TextStyle(
                                color: ColorUtils.textColor,
                              ),
                            ),
                            onTap: () {
                              drawerController.goToPage(
                                page: NameRouts.sample3,
                              );
                            }),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.bookmark,
                          title: AutoSizeText(
                            "نشان شده ها",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            if (Blocs.user.user is UserModel) {
                              drawerController.goToPage(
                                page: NameRouts.sample4,
                              );
                            } else {
                              AlertHelper.showLoginAlert(
                                  title:
                                      'برای مشاهده لیست نشان شده ها ابتدا باید وارد حساب کاربری خود شوید',
                                  onTap: () {
                                    Get.back();
                                    drawerController.goToLoginPage();
                                  });
                            }
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.entertainment,
                          title: AutoSizeText(
                            "سرگرمی",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            drawerController.goToPage(
                              page: NameRouts.sample5,
                            );
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.petGram,
                          title: AutoSizeText(
                            "پت گرام",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            drawerController.goToPage(
                              page: NameRouts.sample6,
                            );
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.knowledge,
                          title: AutoSizeText(
                            "دانستنی ها",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            drawerController.goToPage(
                              page: NameRouts.sample7,
                            );
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.aboutUs,
                          title: AutoSizeText(
                            "درباره ما",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            Get.back();
                            showModalBottomSheet(
                              context: Get.context!,
                              enableDrag: false,
                              elevation: 50.0,
                              isDismissible: true,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (BuildContext context) =>
                                  Sample8(),
                            );
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.logic,
                          title: AutoSizeText(
                            "قوانین و مقررات",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {

                            Get.back();
                            showModalBottomSheet(
                              context: Get.context!,
                              enableDrag: false,
                              elevation: 50.0,
                              isDismissible: true,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (BuildContext context) =>
                                  Sample9(),
                            );
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.contactUs,
                          title: AutoSizeText(
                            "تماس با ما",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            if (Blocs.user.user is UserModel) {
                              drawerController.goToPage(
                                page: NameRouts.sample10,
                              );
                            } else {
                              AlertHelper.showLoginAlert(
                                  title:
                                      'برای ارسال پیام به پشتیبانی ابتدا باید ثبت نام کنید',
                                  onTap: () {
                                    Get.back();
                                    drawerController.goToLoginPage();
                                  });
                              // AlertHelper.showLoginAlert(
                              //   context: context,
                              //   size: size,
                              //   title:
                              //       'برای مشاهده لیست آدرس ها ابتدا باید وارد حساب کاربری خود شوید',
                              //   page: RegisterScreen(
                              //     page: HomeScreen(),
                              //   ),
                              // );
                            }
                          },
                        ),
                        WidgetHelper.menuItem(
                          icon: IconHelpers.instagram,
                          title: AutoSizeText(
                            "اینستاگرام ما",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          onTap: () {
                            launch(
                                'https://instagram.com/louneh.app?utm_medium=copy_link');
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.only(left: 18.0, bottom: 1.0),
                    height: Get.height * .05,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white70,
                          Colors.white30,
                          Colors.white12,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(56.0),
                        right: Radius.zero,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
