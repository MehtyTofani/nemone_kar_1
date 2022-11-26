import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Bloc/Blocs.dart';
import '../Const/ColorUtils.dart';
import '../MainModel/UserModel.dart';

class IconHelpers {
  static SvgPicture myAds = SvgPicture.asset(
    'assets/images/icon/myAds.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture affiliate = SvgPicture.asset(
    'assets/images/icon/affiliate.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture club = SvgPicture.asset(
    'assets/images/icon/club.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture entertainment = SvgPicture.asset(
    'assets/images/icon/entertainment.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture match = SvgPicture.asset(
    'assets/images/icon/match.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture bookmark = SvgPicture.asset(
    'assets/images/icon/bookmark.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture petGram = SvgPicture.asset(
    'assets/images/icon/petGram.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture knowledge = SvgPicture.asset(
    'assets/images/icon/knowledge.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture aboutUs = SvgPicture.asset(
    'assets/images/icon/aboutUs.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture logic = SvgPicture.asset(
    'assets/images/icon/logic.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture contactUs = SvgPicture.asset(
    'assets/images/icon/contactUs.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture instagram = SvgPicture.asset(
    'assets/images/icon/instagram.svg',
    fit: BoxFit.cover,
    // height: 80.0,
    // width: 80.0,
  );
  static SvgPicture exit = SvgPicture.asset(
    'assets/images/icon/exit.svg',
    fit: BoxFit.cover,
    color:(Blocs.user.user is UserModel)? ColorUtils.red:ColorUtils.editGreen,
    // height: 80.0,
    // width: 80.0,
  );
}
