import 'dart:convert';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Bloc/Blocs.dart';
import '../Const/ColorUtils.dart';
import '../Const/Consts.dart';
import '../Controller/HomeController.dart';
import '../Controller/ProfileController.dart';
import '../Helpers/BaseRequestUtil.dart';
import '../Helpers/ProjectRequestUtils.dart';
import '../Helpers/StorageUtils.dart';
import '../Helpers/ViewHelper.dart';
import 'Model/CityModel.dart';
import 'Model/StateModel.dart';

class SelectCityScreen extends StatefulWidget {
  bool? isProfile;
  ProfileController? controller;

  SelectCityScreen({this.isProfile, this.controller});

  @override
  _SelectCityScreenState createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  ProjectRequestUtils req = ProjectRequestUtils();
  HomeController homeController = Get.put(HomeController());
  Animation? _animation;
  bool stateSelected = false;
  bool citySelected = false;
  double? cityWidth = 0.0;

  bool? isStateLoaded = false;
  bool? isCityLoaded = false;

  double dividerHeight = 0.0;
  double submitHeight = 0.0;

  List<StatesModel> stateList = [];
  List<CityModel> cityList = [];

  getStates() async {
    ApiResult result = await this.req.getStates();
    if (result.isDone) {
      stateList = StatesModel.listFromJson(result.data);
      setState(() {
        isStateLoaded = true;
      });
      selectState();
    }
  }

  selectState() async {
    if(widget.isProfile!){
      if(widget.controller!.state is StatesModel){
        stateList.forEach((element) {
          if (element.stateId == widget.controller!.state!.stateId ) {
            setState(() {
              element.isSelected = true;
              stateSelected = true;
            });
            getCity(
              stateId: element.stateId.toString(),
            );
          }
        });
      }
    }else{
      StorageUtils.getCity().then((value) {
        if (value != null) {
          stateList.forEach((element) {
            if ((element.stateId ==
                StatesModel.fromJson(jsonDecode(value)['state']).stateId)) {
              setState(() {
                element.isSelected = true;
                stateSelected = true;
              });
              getCity(
                stateId: element.stateId.toString(),
              );
            }
          });
        }
      });
    }
  }

  getCity({String? stateId}) async {
    ApiResult result = await this.req.getCity(
          id: stateId,
        );
    if (result.isDone) {
      cityList = CityModel.listFromJson(result.data);
      setState(() {
        isCityLoaded = true;
      });

      selectCity();
    }
  }

  selectCity() async {
    if(widget.isProfile!){
      if (widget.controller!.city is CityModel) {
        cityList.forEach((element) {
          if (element.id == widget.controller!.city!.id) {
            setState(() {
              element.isSelected = true;
              citySelected = true;
            });
          }
        });
        submitHeight = Get.height * .06;
      }
    }else{
      StorageUtils.getCity().then((value) {
        if (value != null) {
          cityList.forEach((element) {
            if ((element.id ==
                CityModel.fromJson(jsonDecode(value)['city']).id)) {
              setState(() {
                element.isSelected = true;
                citySelected = true;
              });
            }
          });
          submitHeight = Get.height * .06;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStates();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 175), vsync: this);
    _animation =
        IntTween(begin: (Get.width * .5).toInt(), end: (Get.width * .2).toInt())
            .animate(_animationController!);
    _animation!.addListener(
      () => setState(
        () {
          // stateSelected = !stateSelected!;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Container(
            height: Get.height * .7,
            width: Get.width,
            // padding: EdgeInsets.symmetric(
            //   horizontal: Get.width * .03,
            // ),
            // margin: EdgeInsets.symmetric(
            //   horizontal: Get.width * .02,
            //   vertical: Get.height * .01,
            // ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: radiusAll10,
            ),
            child: Column(
              children: [
                _buildSelectPart(),
                SizedBox(
                  height: 16.0,
                ),
                _buildSubmitCity()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectPart() {
    return Expanded(
      child: Container(
        width: Get.width,
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .03,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * .02,
          vertical: Get.height * .01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radiusAll10,
        ),
        child: Row(
          children: <Widget>[
            _cityPart(),
            AnimatedContainer(
              duration: Duration(
                milliseconds: 500,
              ),
              width: 1.0,
              color: ColorUtils.main,
              margin: EdgeInsets.symmetric(
                vertical: Get.height * .05,
              ),
              height: dividerHeight,
            ),
            _statePart(),
          ],
        ),
      ),
    );
  }

  Widget _statePart() {
    return Expanded(
      flex: _animation!.value,
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: (isStateLoaded!)
            ? ListView.builder(
                itemCount: stateList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    _stateListItem(item: stateList[index]),
              )
            : Center(
                child: ViewHelper.loadingAnimation(),
              ),
      ),
    );
  }

  Widget _stateListItem({StatesModel? item}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      highlightColor: Colors.black12,
      splashColor: Colors.grey.withOpacity(0.1),
      onTap: () {
        stateList.forEach((element) {
          element.isSelected = false;
        });
        getCity(
          stateId: item!.stateId.toString(),
        );
        if (_animationController!.value == 0.0) {
          _animationController!.forward();
          setState(() {
            stateSelected = true;
            cityWidth = double.maxFinite;
            item.isSelected = true;
            Future.delayed(Duration(milliseconds: 300), () {
              setState(() {
                dividerHeight = Get.height * .65;
              });
            });
          });
        } else {
          _animationController!.reverse();
          setState(() {
            stateSelected = false;
            cityWidth = 0.0;
            dividerHeight = 0.0;
          });
        }
      },
      child: AnimatedContainer(
        width: Get.width,
        height: Get.height * .05,
        padding: paddingSymmetricH16,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * .01,
          horizontal: Get.width * .02,
        ),
        decoration: BoxDecoration(
          color: (item!.isSelected! && stateSelected)
              ? ColorUtils.main
              : Colors.white,
          borderRadius: radiusAll12,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 200),
        child: Row(
          mainAxisAlignment: (stateSelected)
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            (stateSelected)
                ? Container()
                : Icon(
                    Icons.arrow_back_ios,
                    color: (stateSelected && item.isSelected!)
                        ? Colors.white
                        : ColorUtils.grey,
                    size: 18.0,
                  ),
            AutoSizeText(
              item.stateName!,
              maxLines: 1,
              maxFontSize: 20.0,
              minFontSize: 8.0,
              style: TextStyle(
                  fontSize: 14.0,
                  color: (stateSelected && item.isSelected!)
                      ? Colors.white
                      : (stateSelected)
                          ? ColorUtils.grey.withOpacity(.4)
                          : ColorUtils.textColor),
            ),
            Container(
              width: (stateSelected) ? 0.0 : Get.width * .05,
            )
          ],
        ),
      ),
    );
  }

  Widget _cityPart() {
    return Expanded(
      flex: (stateSelected) ? 150 : 0,
      child: Container(
        height: double.maxFinite,
        width: cityWidth,
        color: Colors.white,
        child: (isCityLoaded!)
            ? (cityList.length == 0)
                ? ViewHelper.showEmptyList()
                : ListView.builder(
                    itemCount: cityList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        _cityListItem(item: cityList[index]),
                  )
            : Center(
                child: ViewHelper.loadingAnimation(),
              ),
      ),
    );
  }

  Widget _cityListItem({CityModel? item}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      highlightColor: Colors.black12,
      splashColor: Colors.grey.withOpacity(0.1),
      onTap: () {
        cityList.forEach((element) {
          element.isSelected = false;
        });
        setState(() {
          item!.isSelected = true;
          citySelected = true;
          submitHeight = Get.height * .06;
        });
        print(item!.isSelected);
      },
      child: AnimatedContainer(
        width: Get.width,
        height: Get.height * .05,
        padding: paddingSymmetricH16,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * .01,
          horizontal: Get.width * .02,
        ),
        decoration: BoxDecoration(
          color: (item!.isSelected && citySelected)
              ? ColorUtils.main
              : Colors.white,
          borderRadius: radiusAll12,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 200),
        child: Center(
          child: AutoSizeText(
            item.name!,
            maxLines: 1,
            maxFontSize: 20.0,
            minFontSize: 8.0,
            style: TextStyle(
              fontSize: 14.0,
              color: (citySelected && item.isSelected)
                  ? Colors.white
                  : ColorUtils.textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitCity() {
    return GestureDetector(
      onTap: () {
        StatesModel? selectedState =
            stateList.singleWhere((element) => element.isSelected == true);
        CityModel? selectedCity =
            cityList.singleWhere((element) => element.isSelected == true);
        if (widget.isProfile!) {
          widget.controller!.setPositionData(
            myState: selectedState,
            myCity: selectedCity,
          );
          widget.controller!.hasSetState = true;
        } else {
          Blocs.position.addPosition(
            myCity:
                cityList.singleWhere((element) => element.isSelected == true),
            myState:
                stateList.singleWhere((element) => element.isSelected == true),
          );
          homeController.getBanner(
            state: selectedState,
            city: selectedCity,
          );
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: Get.width,
        height: submitHeight,
        margin: paddingSymmetricH30,
        decoration: BoxDecoration(
          color: ColorUtils.green,
          borderRadius: radiusAll12,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            ),
          ],
        ),
        child: Center(
          child: AutoSizeText(
            'تایید',
            maxFontSize: 20.0,
            minFontSize: 12.0,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
