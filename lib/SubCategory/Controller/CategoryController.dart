import 'package:get/get.dart';
import '../../Helpers/BaseRequestUtil.dart';
import '../../Helpers/ProjectRequestUtils.dart';
import '../Model/CategoryModel.dart';

class CategoryController extends GetxController {
  ProjectRequestUtils req = ProjectRequestUtils();

  List<CategoryModel> model = [];

  late RxList<List<CategoryModel>> categoryList;

  late List<CategoryModel> mainCategoryList;

  RxBool isLoaded = false.obs;

  @override
  void onInit() {
    categoryList = Get.arguments[0];
    model.add(
      Get.arguments[1],
    );
    Future.delayed(Duration(seconds: 1), () {
      getMainCategory(item: model.last);
    });
    super.onInit();
  }

  void getMainCategory({CategoryModel? item}) async {
    setBanner(item: item);
    ApiResult apiResult = await this.req.getCategory(
          id: item!.id.toString(),
        );
    if (apiResult.isDone) {
      mainCategoryList = CategoryModel.listFromJson(apiResult.data);
      this.categoryList.add(mainCategoryList);
      // this.categoryList.refresh();
      this.isLoaded.value = true;
    }
  }

  setBanner({CategoryModel? item}) {
    model.add(item!);
    update();
  }

  void previousList() {
    if (categoryList.length == 1) {
      Get.back();
    } else {
      if (categoryList.length == 2) {
        Get.back();
      } else {
        categoryList.removeLast();
        model.removeLast();
      }
    }
    update();
  }

  // void goToAdsList({CategoryModel? item, int? index}) {
  //   Get.to(() => AdsListScreen(item: item, index: index), arguments: [
  //     item!.id.toString(),
  //   ]);
  // }
}
