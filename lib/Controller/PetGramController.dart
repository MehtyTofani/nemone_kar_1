import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../Bloc/Blocs.dart';
import '../Helpers/AlertHelpre.dart';
import '../Helpers/BaseRequestUtil.dart';
import '../Helpers/ProjectRequestUtils.dart';
import '../Helpers/ViewHelper.dart';

class PetGramController extends GetxController {
  ProjectRequestUtils req = ProjectRequestUtils();
  bool isLoaded = false;
  PageController? pageController;
  XFile? postImage;
  XFile? videoFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController postTitleController = TextEditingController();
  VideoPlayerController? controller;
  // List<PetGramModel> petGramList = [];

  int page = 1;

  ScrollController? scrollController;


  RxBool isRefreshLoaded = false.obs;
  bool hastNext = false;

  getData() async {
    ApiResult result = await this.req.getPetgramPost(page: page.toString());
    if (result.isDone) {
      for (var o in result.data['list']) {
        // petGramList.insert(0, PetGramModel.fromJson(o));
      }
      hastNext = result.data['hasNext'];
      isLoaded = true;
      page = page + 1 ;
    } else {
      ViewHelper.errorSnackBar(
        message: 'خطایی رخ داد',
      );
    }
    update();
  }

  _scrollListener() {
    if (scrollController!.offset >=
        scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      if (hastNext) {
        getNextData();
      }
    }
  }


  getNextData() async {
    isRefreshLoaded.value = true;
    ApiResult result = await this.req.getPetgramPost(page: page.toString());
    isRefreshLoaded.value = false;
    if (result.isDone) {
      for (var o in result.data['list']) {
        // petGramList.insert(0, PetGramModel.fromJson(o));
      }
      isLoaded = true;
      hastNext = result.data['hasNext'];
      page = page + 1 ;
    } else {
      ViewHelper.errorSnackBar(
        message: 'خطایی رخ داد',
      );
    }
    update();
  }

  @override
  void onInit() {
    getData();
    controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    scrollController = ScrollController(initialScrollOffset: 0.0);
    scrollController!.addListener(_scrollListener);
    pageController = PageController(initialPage: 0);
    super.onInit();
  }


  @override
  void onClose() {
    videoFile = null;
    postImage = null;
    postTitleController.text = '';
    super.onClose();
  }

  void showAddPostModal() {
    // showMaterialModalBottomSheet(
    //   context: Get.context!,
    //   isDismissible: false,
    //   enableDrag: false,
    //   builder: (BuildContext context) => AddPostPetGramModal(petGramController: this,),
    // );
  }

  void goToLoginPage() {
    AlertHelper.showLoginAlert(
        title: 'برای افزودن پست ابتدا باید ثبت نام کنید',
        onTap: () {
          Get.back();
          // Get.to(
          //   () => RegisterScreen(),
          //   arguments: [
          //     PetGramScreen(),
          //   ],
          // );
        });
  }

  // void changeSwitch({PetGramModel? item}) async {
  //   EasyLoading.show();
  //   ApiResult result = await this.req.likePetGram(id: item!.id.toString());
  //   EasyLoading.dismiss();
  //   if (result.isDone) {
  //     item.individualLike = !item.individualLike!;
  //     ViewHelper.successSnackBar(message: result.data);
  //     if (item.individualLike!) {
  //       item.like = item.like! + 1;
  //     } else {
  //       item.like = item.like! - 1;
  //     }
  //   } else {
  //     ViewHelper.errorSnackBar(
  //       message: 'خطایی رخ داد',
  //     );
  //   }
  //   update();
  // }
  //



  // void showPickerImageAlert({bool? video}) {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: Get.context!,
  //     builder: (_) => Directionality(
  //       textDirection: TextDirection.rtl,
  //       child: AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         scrollable: true,
  //         backgroundColor: Colors.transparent,
  //         elevation: 50.0,
  //         content: SelectSourceImagePickerAlert(
  //           cameraFunc: () {
  //             cameraPick(
  //               video: video,
  //             );
  //           },
  //           galleryFunc: () {
  //             cameraPick(
  //               video: video,
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future cameraPick({bool? video}) async {
    Get.back();
    if (video!) {
      _picker.pickVideo(source: ImageSource.camera).then((value) {
        videoFile = value;
        controller = VideoPlayerController.file(File(videoFile!.path))
          ..initialize().then((_) {
            controller!.play();
            controller!.setLooping(true);
          });
        update();
      });
    } else {
      _picker.pickImage(source: ImageSource.camera).then((value) {
        postImage = value;
        update();
      });
    }

  }

  Future galleryPick({bool? video}) async {
    Get.back();
    if (video!) {
      _picker.pickVideo(source: ImageSource.gallery).then((value) {
        videoFile = value;
        controller = VideoPlayerController.file(File(videoFile!.path))
          ..initialize().then((_) {
            controller!.play();
            controller!.setLooping(true);
          });
        update();
      });
    } else {
      _picker.pickImage(source: ImageSource.gallery).then((value) {
        postImage = value;
        update();
      });
    }
  }

  void changePageControllerToPage({int? page}) {
    pageController!.animateToPage(
      page!,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void submitPost() async {
    EasyLoading.show();

    Uri uri = Uri.parse('http://new.louneh.louneh.com/admin/Petgrams/API/_addpost');
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);

    request.headers['token'] = 'test';
    request.fields['caption'] = postTitleController.text;
    request.fields['individualId'] = Blocs.user.user!.individualId.toString();

    if (videoFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          File(videoFile!.path).path,
        ),
      );
    } else {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          File(postImage!.path).path,
        ),
      );
    }
    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);
    ApiResult result = ApiResult(data: jsonDecode(res.body)['data'] , isDone: jsonDecode(res.body)['isDone']);
    EasyLoading.dismiss();
    if(result.isDone){
      ViewHelper.successSnackBar(message: result.data);
      Future.delayed(Duration(seconds: 3) , (){
        Get.back();
        onClose();
        // petGramList.clear();
        isLoaded = false;
        page = 1;
        getData();
      });
    }
  }

  // void playVideo({PetGramModel? item}) {
  //   if (item!.controller!.value.isPlaying) {
  //     item.controller!.pause();
  //     print('pause');
  //   } else {
  //     item.controller!.play();
  //     print('play');
  //   }
  //   update();
  // }
}
