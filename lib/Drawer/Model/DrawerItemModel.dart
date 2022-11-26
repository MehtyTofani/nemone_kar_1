import 'package:flutter/cupertino.dart';

class DrawerItemModel{

  String? title;
  Widget? icon;
  GestureTapCallback? onTap;

  DrawerItemModel({this.title, this.icon, this.onTap});
}