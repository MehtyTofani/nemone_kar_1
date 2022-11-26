import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Bloc/Blocs.dart';
import '../../Const/ColorUtils.dart';
import '../../Const/Consts.dart';

class DrawerProfilePart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .1,
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: radiusAll12,
                color: Colors.white,
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
              child: Center(
                child: (Blocs.user.user == null)
                    ? Icon(
                        Icons.person_pin,
                        color: ColorUtils.grey,
                        size: 30.0,
                      )
                    : ClipRRect(
                        borderRadius: radiusAll12,
                        child: (Blocs.user.user!.image!.length > 10)
                            ? FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                height: double.maxFinite,
                                width: double.maxFinite,
                                placeholder: 'assets/images/pattern.gif',
                                image: Blocs.user.user!.image!,
                              )
                            : Icon(
                                Icons.person_pin,
                                color: ColorUtils.grey,
                                size: 30.0,
                              ),
                      ),
              ),
            ),
          ),
          SizedBox(
            width: Get.width * .02,
          ),
          Flexible(
            flex: 2,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: (Blocs.user.user != null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '${Blocs.user.user!.firstName!} ${Blocs.user.user!.lastName!}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: ColorUtils.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'عضویت عادی',
                              style: TextStyle(
                                color: ColorUtils.grey,
                                fontSize: 12.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/profile');
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: Container(
                                height: Get.width * .08,
                                width: Get.width * .08,
                                decoration: BoxDecoration(
                                  borderRadius: radiusAll6,
                                  border: Border.all(
                                    color: ColorUtils.green,
                                    width: 1.0,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.edit,
                                    color: ColorUtils.green,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: AutoSizeText(
                        'کاربر مهمان',
                        maxFontSize: 18.0,
                        minFontSize: 10.0,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
