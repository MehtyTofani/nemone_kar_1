import 'package:get/get.dart';
import '../Home/HomeScreen.dart';
import '../MyAds/MyAdsScreen.dart';
import '../Sample1/Sample1.dart';
import '../Sample10/Sample10.dart';
import '../Sample11/Sample11.dart';
import '../Sample2/Sample2.dart';
import '../Sample3/Sample3.dart';
import '../Sample4/Sample4.dart';
import '../Sample5/Sample5.dart';
import '../Sample6/Sample6.dart';
import '../Sample7/Sample7.dart';
import '../Sample8/Sample8.dart';
import '../Sample9/Sample9.dart';
import '../Splash/SplashScreen.dart';


class NameRouts{
  static const String homeScreen = '/home';
  static const String splashScreen = '/splash';
  static const String myAds = '/myAdsScreen';
  static const String sample1 = '/sample1';
  static const String sample2 = '/sample2';
  static const String sample3 = '/sample3';
  static const String sample4 = '/sample4';
  static const String sample5 = '/sample5';
  static const String sample6 = '/sample6';
  static const String sample7 = '/sample7';
  static const String sample8 = '/sample8';
  static const String sample9 = '/sample9';
  static const String sample10 = '/sample10';
  static const String sample11 = '/sample11';



  // static const String introScreen = '/intro';
  // static const String registerScreen = '/register';
  // static const String aboutUs = '/aboutUs';
  // static const String bookmark = '/bookmark';
  // static const String affiliateMarketing = '/affiliateMarketing';
  // static const String club = '/club';
  // static const String contactUs = '/contactUs';
  // static const String drawer = '/drawer';
  // static const String entertainment = '/entertainment';
  // static const String instagram = '/instagram';
  // static const String knowledge = '/knowledge';
  // static const String logic = '/logic';
  // static const String match = '/match';

  // static const String petGram = '/petGram';
  // static const String profile = '/profile';
  // static const String selectCity = '/selectCity';
  // static const String addAds = '/addAds';
  // static const String search = '/search';
  // static const String homeAffiliate = '/homeAffiliate';
  // static const String singleCategoryScreen = '/singleCategoryScreen';
}


class PageRout{
  static List<GetPage> pages = [
    GetPage(name: NameRouts.homeScreen, page: ()=> HomeScreen()),
    GetPage(name: NameRouts.splashScreen, page: ()=> SplashScreen()),
    GetPage(name: NameRouts.myAds, page: ()=> MyAdsScreen()),
    GetPage(name: NameRouts.sample1, page: ()=> Sample1()),
    GetPage(name: NameRouts.sample2, page: ()=> Sample2()),
    GetPage(name: NameRouts.sample3, page: ()=> Sample3()),
    GetPage(name: NameRouts.sample4, page: ()=> Sample4()),
    GetPage(name: NameRouts.sample5, page: ()=> Sample5()),
    GetPage(name: NameRouts.sample6, page: ()=> Sample6()),
    GetPage(name: NameRouts.sample7, page: ()=> Sample7()),
    GetPage(name: NameRouts.sample8, page: ()=> Sample8()),
    GetPage(name: NameRouts.sample9, page: ()=> Sample9()),
    GetPage(name: NameRouts.sample10, page: ()=> Sample10()),
    GetPage(name: NameRouts.sample11, page: ()=> Sample11()),



    // GetPage(name: NameRouts.singleCategoryScreen, page: ()=> SingleCategoryScreen()),
    // GetPage(name: NameRouts.introScreen, page: ()=> IntroScreen()),
    // GetPage(name: NameRouts.registerScreen, page: ()=> RegisterScreen()),
    // GetPage(name: NameRouts.aboutUs, page: ()=> AboutUsScreen()),
    // GetPage(name: NameRouts.affiliateMarketing, page: ()=> AffiliateMarketingScreen()),
    // GetPage(name: NameRouts.bookmark, page: ()=> BookmarkScreen()),
    // GetPage(name: NameRouts.club, page: ()=> ClubScreen()),
    // GetPage(name: NameRouts.contactUs, page: ()=> ContactUsScreen()),
    // GetPage(name: NameRouts.drawer, page: ()=> DrawerScreen()),
    // GetPage(name: NameRouts.entertainment, page: ()=> GamesScreen()),
    // GetPage(name: NameRouts.instagram, page: ()=> InstagramScreen()),
    // GetPage(name: NameRouts.knowledge, page: ()=> KnowledgeScreen()),
    // GetPage(name: NameRouts.logic, page: ()=> LogicScreen()),
    // GetPage(name: NameRouts.match, page: ()=> MatchScreen()),
    // GetPage(name: NameRouts.myAds, page: ()=> MyAdsScreen()),
    // GetPage(name: NameRouts.petGram, page: ()=> PetGramScreen()),
    // GetPage(name: NameRouts.profile, page: ()=> ProfileScreen()),
    // GetPage(name: NameRouts.selectCity, page: ()=> SelectCityScreen()),
    // GetPage(name: NameRouts.addAds, page: ()=> AddAdsScreen()),
    // GetPage(name: NameRouts.search, page: ()=> SearchScreen()),
    // GetPage(name: NameRouts.homeAffiliate, page: ()=> HomeAffiliateScreen()),
  ];
}