
import 'package:get/get.dart';
import '../Bloc/Blocs.dart';
import '../Const/WebControllers.dart';
import '../Const/WebMethods.dart';
import '../MainModel/UserModel.dart';
import 'BaseRequestUtil.dart';

class ProjectRequestUtils extends RequestsUtil {
  Future<ApiResult> getCategory({String? id}) async {
    return await this.makeRequest(
        webMethod: WebMethods.apiCategoryApp,
        webController: WebControllers.Categories,
        body: {
          'categoryId': id,
        });
  }

  Future<ApiResult> saveChangesData({
    String? fName,
    String? lName,
    String? gender,
    String? stateId,
    String? cityId,
    String? image,
    String? email,
    String? telegram,
    String? instagram,
    String? webSite,
    String? cooperation,
  }) async {
    return await this.makeRequest(
        webMethod: WebMethods.editProfile,
        webController: WebControllers.Customers,
        body: {
          'fname': fName,
          'lname': lName,
          'mobile': Blocs.user.user!.mobile,
          'gender': gender,
          'state_id': stateId,
          'city_id': cityId,
          'region_id': '',
          'cooperation': cooperation,
          'image': image,
          'instagram': instagram,
          'telegram': telegram,
          'website': webSite,
          'email': email,
        });
  }

  Future<ApiResult> getStates() async {
    return await this.makeRequest(
      webMethod: WebMethods.apiStates,
      webController: WebControllers.States,
    );
  }

  Future<ApiResult> getSingleKnowledge({String? id}) async {
    return await this.makeRequest(
        webMethod: WebMethods.getSingleKnow,
        webController: WebControllers.Knows,
        body: {
          'knowId': id,
        });
  }

  Future<ApiResult> getBookmarks({int? page}) async {
    return await this.makeRequest(
        webMethod: WebMethods.individualBookmarkes,
        webController: WebControllers.Customers,
        body: {
          'individualId': Blocs.user.user!.individualId.toString(),
          'page': page.toString(),
        });
  }

  Future<ApiResult> aboutUsInfo() async {
    return await this.makeRequest(
      webMethod: WebMethods.getInformations,
      webController: WebControllers.Infos,
    );
  }

  Future<ApiResult> editAd({
    String? adId,
    String? adTypeId,
    String? ad_name,
    String? priceType_id,
    String? ad_brand,
    String? ad_gender,
    String? ad_pet_name,
    String? ad_price,
    String? image,
    String? ad_detail,
    String? ad_affiliate,
    String? ad_affiliate_price,
  }) async {
    return await this.makeRequest(
        webMethod: WebMethods.editAds,
        webController: WebControllers.Ads,
        body: {
          'adId': adId,
          'adType_id': adTypeId,
          'ad_name': ad_name,
          'priceType_id': priceType_id,
          'ad_brand': ad_brand,
          'ad_gender': ad_gender,
          'ad_pet_name': ad_pet_name,
          'ad_price': ad_price,
          'image': image,
          'ad_detail': ad_detail,
          'ad_affiliate': ad_affiliate,
          'ad_affiliate_price': ad_affiliate_price,
        });
  }

  Future<ApiResult> editAffiliateAd({
    String? shopAdId,
    String? adName,
    String? adPrice,
    String? adImage,
    String? adDetails,
  }) async {
    return await this.makeRequest(
        webMethod: WebMethods.editShopAds,
        webController: WebControllers.ShopAds,
        body: {
          'shopAdId': shopAdId,
          'adName': adName,
          'adPrice': adPrice,
          'adImage': adImage,
          'adDetails': adDetails,
        });
  }

  Future<ApiResult> getBanner() async {
    return await this.makeRequest(
      webMethod: WebMethods.GetBanners,
      webController: WebControllers.Banners,
    );
  }

  Future<ApiResult> search({
    String? text,
    String? page,
    String? categories,
  }) async {
    return await this.makeRequest(
        webMethod: WebMethods.searchAds,
        webController: WebControllers.Ads,
        body: {'search': text, 'categories': categories, 'page': page});
  }

  Future<ApiResult> getAffiliateList({String? page}) async {
    return await this.makeRequest(
      webMethod: WebMethods.affiliateAds,
      webController: WebControllers.Ads,
      body: {
        'page': page,
      },
    );
  }

  Future<ApiResult> deleteAd({String? adId}) async {
    return await this.makeRequest(
      webMethod: WebMethods.deleteAds,
      webController: WebControllers.Ads,
      body: {
        'adId': adId,
      },
    );
  }

  Future<ApiResult> sendTicket({
    String? ticketText,
    String? email,
  }) async {
    return await this.makeRequest(
      webMethod: WebMethods.sendTicket,
      webController: WebControllers.Contact,
      body: {
        'individualId': Blocs.user.user!.individualId.toString(),
        'email': email,
        'message': ticketText,
      },
    );
  }

  Future<ApiResult> likeMatches({String? postId}) async {
    return await this.makeRequest(
      webMethod: WebMethods.like,
      webController: WebControllers.RaceLikes,
      body: {
        'raceId': postId,
        'individualId': Blocs.user.user!.individualId.toString()
      },
    );
  }

  Future<ApiResult> deleteProfileImage() async {
    return await this.makeRequest(
      webMethod: WebMethods.deleteImage,
      webController: WebControllers.Customers,
      body: {'individualId': Blocs.user.user!.individualId.toString()},
    );
  }

  Future<ApiResult> getMatchesList({String? page}) async {
    return await this.makeRequest(
      webMethod: WebMethods.getMatches,
      webController: WebControllers.Matches,
      body: {
        'page': page,
      },
    );
  }

  Future<ApiResult> singleMatchesData({
    String? id,
    String? page,
  }) async {
    return await this.makeRequest(
      webMethod: WebMethods.getAllPosts,
      webController: WebControllers.Races,
      body: {
        'page': page,
        'individualId': Blocs.user.user!.individualId.toString(),
        'matchId': id,
      },
    );
  }

  Future<ApiResult> getAffiliateHomeData(
      {String? page, String? individualId}) async {
    return await this.makeRequest(
      webMethod: WebMethods.myShop,
      webController: WebControllers.ShopAds,
      body: {
        'individualId': individualId,
        'page': page,
      },
    );
  }

  Future<ApiResult> getAffiliateShopList({
    String? page,
    String? stateId,
    String? cityId,
  }) async {
    return await this.makeRequest(
      webMethod: WebMethods.getAllCoopration,
      webController: WebControllers.Cooprations,
      body: {
        'page': page,
        'stateId': stateId,
        'cityId': cityId,
      },
    );
  }

  Future<ApiResult> editShop({String? shopName, String? banner}) async {
    return await this.makeRequest(
      webMethod: WebMethods.editShop,
      webController: WebControllers.Cooprations,
      body: {
        'individualId': Blocs.user.user!.individualId.toString(),
        'shopName': shopName,
        'banner': banner,
      },
    );
  }

  Future<ApiResult> deleteAffiliateAd({String? id}) async {
    return await this.makeRequest(
      webMethod: WebMethods.deleteShopAd,
      webController: WebControllers.ShopAds,
      body: {
        'shopAdId': id,
      },
    );
  }

  Future<ApiResult> getAffiliateSingle({String? adId}) async {
    return await this.makeRequest(
      webMethod: WebMethods.singleAffiliateAd,
      webController: WebControllers.ShopAds,
      body: {
        'shopAdId': adId,
      },
    );
  }

  Future<ApiResult> getKnow({String? page}) async {
    return await this.makeRequest(
        webMethod: WebMethods.getKnows,
        webController: WebControllers.Knows,
        body: {
          'page': page,
        });
  }

  Future<ApiResult> addToAffiliate({String? id}) async {
    return await this.makeRequest(
        webMethod: WebMethods.addAdsToShop,
        webController: WebControllers.ShopAds,
        body: {
          'individualId': Blocs.user.user!.individualId.toString(),
          'adId': id.toString()
        });
  }

  Future<ApiResult> getPetgramPost({String? page}) async {
    return await this.makeRequest(
        webMethod: WebMethods.getAllPosts,
        webController: WebControllers.Petgrams,
        body: {
          'page': page,
          'individualId': (Blocs.user.user is UserModel)
              ? Blocs.user.user!.individualId.toString()
              : '',
        });
  }

  Future<ApiResult> likePetGram({String? id}) async {
    return await this.makeRequest(
        webMethod: WebMethods.like,
        webController: WebControllers.Likes,
        body: {
          'petgramId': id,
          'individualId': Blocs.user.user!.individualId.toString(),
        });
  }

  Future<ApiResult> getAllTickets() async {
    return await this.makeRequest(
        webMethod: WebMethods.getIndividualsTicket,
        webController: WebControllers.Contact,
        body: {
          'individualId': Blocs.user.user!.individualId.toString(),
          'page': '1',
        });
  }

  Future<ApiResult> getGames() async {
    return await this.makeRequest(
      webMethod: WebMethods.getGames,
      webController: WebControllers.Games,
    );
  }

  Future<ApiResult> submitAds({FormData? data}) async {
    return await this.submitFile(
      data: data,
      webControllers: WebControllers.Ads,
      webMethods: WebMethods.submitAd,
    );
  }

  Future<ApiResult> getAdsType() async {
    return await this.makeRequest(
      webMethod: WebMethods.getAdTypes,
      webController: WebControllers.Adtypes,
    );
  }

  Future<ApiResult> goToBank({String? totalPrice}) async {
    return await this.makeRequest(
        webMethod: WebMethods.onlineBuy,
        webController: WebControllers.CreditActions,
        body: {
          'individualId': Blocs.user.user!.individualId.toString(),
          'amount': totalPrice
        });
  }

  Future<ApiResult> getCity({String? id}) async {
    return await this.makeRequest(
      webMethod: WebMethods.apiCities,
      webController: WebControllers.Cities,
      body: {
        'state_id': id,
      },
    );
  }

  Future<ApiResult> getSubCategory({String? catId}) async {
    return await this.makeRequest(
        webMethod: WebMethods.apiSubCategory,
        webController: WebControllers.Subcats,
        body: {
          'categoryId': catId,
        });
  }

  Future<ApiResult> startLoginRegister({String? mobileNumber}) async {
    return await this.makeRequest(
        webMethod: WebMethods.startLoginRegister,
        webController: WebControllers.Customers,
        body: {
          'mobile': mobileNumber,
        });
  }

  Future<ApiResult> getMyAds({String? page}) async {
    return await this.makeRequest(
        webMethod: WebMethods.getAdsByIndividualId,
        webController: WebControllers.Ads,
        body: {
          'individualId': Blocs.user.user!.individualId.toString(),
          'page': page,
        });
  }

  Future<ApiResult> getSingleAd({String? id}) async {
    return await this.makeRequest(
        webController: WebControllers.Ads,
        webMethod: WebMethods.getSingleAd,
        body: {
          'individualId': (Blocs.user.user is UserModel)
              ? Blocs.user.user!.individualId.toString()
              : '',
          'adId': id,
        });
  }

  Future<ApiResult> login({
    String? mobile,
    String? password,
  }) async {
    return await this.makeRequest(
        webController: WebControllers.Customers,
        webMethod: WebMethods.login,
        body: {
          'mobile': mobile,
          'password': password,
        });
  }

  Future<ApiResult> checkOtp({
    String? mobile,
    String? code,
  }) async {
    return await this.makeRequest(
        webController: WebControllers.Customers,
        webMethod: WebMethods.register,
        body: {
          'mobile': mobile,
          'code': code,
        });
  }

  Future<ApiResult> randomSpecial({
    String? state,
    String? city,
  }) async {
    return await this.makeRequest(
        webController: WebControllers.Categories,
        webMethod: WebMethods.get5RandomSpecial,
        body: {
          'stateId': state,
          'cityId': city,
        });
  }

  Future<ApiResult> randomAds({
    String? state,
    String? city,
    String? id,
  }) async {
    return await this.makeRequest(
        webController: WebControllers.Categories,
        webMethod: WebMethods.get10RandomCats,
        body: {
          'stateId': state,
          'cityId': city,
          'catId': id,
        });
  }

  Future<ApiResult> completeRegister({
    String? mobile,
    String? password,
    String? fName,
    String? lName,
    String? affiliate,
    String? gender,
  }) async {
    return await this.makeRequest(
        webController: WebControllers.Customers,
        webMethod: WebMethods.completeRegister,
        body: {
          'mobile': mobile,
          'password': password,
          'fname': fName,
          'lname': lName,
          'cooperation': affiliate,
          'gender': gender,
        });
  }

  Future<ApiResult> getUserData({String? mobile}) async {
    return await this.makeRequest(
        webController: WebControllers.Customers,
        webMethod: WebMethods.getIndividualInformations,
        body: {
          'mobile': mobile,
        });
  }

  Future<ApiResult> forgetPassword({String? mobile}) async {
    return await this.makeRequest(
      webController: WebControllers.Customers,
      webMethod: WebMethods.forgetPassword,
      body: {
        'mobile': mobile,
      },
    );
  }

  Future<ApiResult> setNewPassword({
    String? mobile,
    String? newPassword,
  }) async {
    return await this.makeRequest(
      webController: WebControllers.Customers,
      webMethod: WebMethods.setpassword,
      body: {'mobile': mobile, 'newpassword': newPassword},
    );
  }

  Future<ApiResult> getAdsList({
    String? id,
    String? page,
  }) async {
    return await this.makeRequest(
      webController: WebControllers.Categories,
      webMethod: WebMethods.categoryApp,
      body: {
        'categoryId': id,
        'page': page,
      },
    );
  }

  Future<ApiResult> bookMark({
    String? id,
  }) async {
    return await this.makeRequest(
      webController: WebControllers.Bookmarks,
      webMethod: WebMethods.bookmark,
      body: {
        'individualId': Blocs.user.user!.individualId.toString(),
        'adId': id,
      },
    );
  }
}
