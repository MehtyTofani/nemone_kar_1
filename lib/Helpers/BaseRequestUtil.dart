import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import '../Const/WebControllers.dart';
import '../Const/WebMethods.dart';


abstract class RequestsUtil extends GetConnect {
  static late String baseRequestUrl;
  static String? token;

  static bool debug = true;

  @override
  void onInit() {
    assert(
      baseRequestUrl == null,
      "baseRequestUrl should be initialized in 'main()'",
    );
    assert(
      token == null,
      "token should be initialized in 'main()'",
    );
    httpClient.addRequestModifier((Request request) async {
      request.headers['token'] = RequestsUtil.token!;
      return request;
    });

    this.baseUrl = baseRequestUrl;
    super.onInit();
  }

  Future<ApiResult> makeRequest({
    required WebControllers webController,
    required WebMethods webMethod,
    Map body = const {},
  }) async {
    String url = this._makePath(webController, webMethod);
    if (debug) {
      print("Request url: $url\nRequest body: ${jsonEncode(body)}\n");
    }
    Response response = await post(
      url,
      body,
      headers: {
        'token': RequestsUtil.token!,
      },
    );
    ApiResult apiResult = new ApiResult();
    print(response.body);
    if (response.statusCode == 200) {
      try {
        if (debug) {
          print(response.body);
        }
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }
    if (debug) {
      print(
          "\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
          "status: ${response.statusCode}\n"
          "isDone: ${apiResult.isDone}\n"
          "requestedMethod: ${apiResult.requestedMethod}\n"
          "data: ${apiResult.data}"
          "}");
    }
    return apiResult;
  }



  Future<ApiResult> submitFile({dynamic data , WebMethods? webMethods ,WebControllers? webControllers })async{
    ApiResult apiResult = new ApiResult();
    String url = this._makePath(webControllers!, webMethods!);


    print(url);
    Response response = await post(
      url,
      data,
      headers: {
        'token': RequestsUtil.token!,
      },
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      try {
        if (debug) {
          print(jsonDecode(response.body));
        }
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        apiResult.requestedMethod = webMethods.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }

    return apiResult;
  }

  String _makePath(WebControllers webController, WebMethods webMethod) {
    return "${RequestsUtil.baseRequestUrl}/admin/${webController.toString().split('.').last}/API/_${webMethod.toString().split('.').last}";
  }
}

class ApiResult {
  late bool isDone;
  String? requestedMethod;
  dynamic data;

  ApiResult({
    this.isDone = false,
    this.requestedMethod,
    this.data,
  });
}
