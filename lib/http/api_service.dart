import 'package:dio/dio.dart';
import 'package:flutter_study/commom_import.dart';

class ApiService {


  void getBanner(Function callback) async {
    DioManager.singleton.dio
        .get(Api.HOME_BANNER, options: _getOptions())
        .then((response) {
      callback(BannerModel(response.data));
    });
  }

  void getArtileList(Function callback, Function errorback, int _page) async {}

  Options _getOptions() {
    Map<String, String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookies"] = cookies.toString();
    return Options(headers: map);
  }
}
