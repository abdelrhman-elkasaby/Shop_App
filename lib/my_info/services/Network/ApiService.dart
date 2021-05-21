import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app2/my_info/utils/Utils.dart';
import 'DioConnectivityRequestRetrier.dart';
class ApiService {
  Dio _dio;
  static const _base = "https://student.valuxapps.com/api/";
  DioCacheManager _manager;
  Connectivity _connectivity = Connectivity();
  ApiService() {
    _dio = Dio()
      ..interceptors.add(
        LogInterceptor(
          responseBody: true,
          error: true,
          requestBody: true,
          requestHeader: true,
        ),
      )
      ..interceptors.add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            connectivity: _connectivity,
            dio: Dio(),
          ),
        ),
      )
      ..interceptors.add(_getCacheManager().interceptor);
  }

  DioCacheManager _getCacheManager() {
    if (null == _manager) {
      _manager = DioCacheManager(CacheConfig(baseUrl: _base));
    }
    return _manager;
  }

  Future<bool> clearCacheOptions() {
    return _manager.clearAll();
  }

  Options _buildCacheOptions({
    Map<String, String> headers,
    Map<String, dynamic> body,
    bool subKey = true,
    bool forceRefresh = true,
  }) {
    return buildCacheOptions(
      const Duration(days: 3),
      maxStale: const Duration(days: 7),
      options: Options(
        headers: headers,
      ),
      forceRefresh: forceRefresh,
      subKey: subKey ? json.encode(body) : "",
    );
  }

  Future<Response> post({
    String url,
    Map<String, dynamic> body,
    Map<String, dynamic> query,
    Map<String, String> headers,
    bool loading = false,
    bool forceRefresh = true,
    BuildContext context,
  }) async {
    if (loading) {
      Utils().alert().showLoadingDialog(context);
    }
    return _dio
        .post(
      _base + url,
      data: body,
      queryParameters: query,
      onReceiveProgress: (int received, int total) {},
      options: _buildCacheOptions(
          headers: headers, forceRefresh: forceRefresh, body: body),
    )
        .whenComplete(() {
      if (loading) {
        EasyLoading.dismiss(animation: true);
      }
    });
    //     .timeout(
    //   Duration(seconds: 30),
    //   onTimeout: () {
    //     EasyLoading.dismiss(animation: true);
    //     Utils().alert().showAlertMessage(
    //           isSuccess: false,
    //           title: AppLocalizations.of(context).translate('networkError'),
    //         );
    //     return;
    //   },
    // );
  }

  Future<Response> get({
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
    bool loading = false,
    bool forceRefresh = true,
    BuildContext context,
  }) {
    if (loading) {
      Utils().alert().showLoadingDialog(context);
    }
    return _dio.get(
      _base + url,
      queryParameters: query,
      onReceiveProgress: (int received, int total) {
        print("test ${(received / total * 100).toStringAsFixed(0) + "%"}");
      },
      options: _buildCacheOptions(
        headers: headers,
        forceRefresh: forceRefresh,
        body: query,
      ),
    ).whenComplete(
          () {
        if (loading) {
          EasyLoading.dismiss(animation: true);
        }
      },
    );
    //     .timeout(
    //   const Duration(seconds: 35),
    //   onTimeout: () {
    //     EasyLoading.dismiss(animation: true);
    //     Utils().alert().showAlertMessage(
    //           isSuccess: false,
    //           title: 'networkError'.localize(context),
    //         );
    //     return;
    //   },
    // );
  }

  Future<Response> upload({
    String url,
    Map<String, dynamic> body,
    Map<String, dynamic> query,
    Map<String, dynamic> headers,
    Function(int received, int total) onProgressSend,
    bool loading = false,
    BuildContext context,
  }) async {
    if (loading) {
      Utils().alert().showLoadingDialog(context);
    }
    FormData formData = FormData.fromMap(body);
    body.forEach((key, value) {
      if ((value) is File) {
        MapEntry<String, MultipartFile> pic = MapEntry(
          "$key",
          MultipartFile.fromFileSync(value.path,
              filename: value.path.split("/").last),
        );
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              "$key",
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      } else {}
    });
    return _dio
        .post(
      _base + url,
      data: formData,
      queryParameters: query,
      onSendProgress: onProgressSend,
      options: Options(
        headers: headers,
      ),
    )
        .whenComplete(() {
      if (loading) {
        EasyLoading.dismiss(animation: true);
      }
    });
    //     .timeout(
    //   const Duration(seconds: 120),
    //   onTimeout: () {
    //     EasyLoading.dismiss(animation: true);
    //     Utils().alert().showAlertMessage(
    //           isSuccess: false,
    //           title: AppLocalizations.of(context).translate(
    //             'networkError',
    //           ),
    //         );
    //     return;
    //   },
    // );
  }

  Future<Response> download(
      String url,
      String dir,
      Function(int received, int total) onProgressRecived,
      ) {
    return _dio.download(
      url,
      dir,
      onReceiveProgress: onProgressRecived,
    );
  }

  void getDioError({var e, BuildContext context}) {
    if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
        DioErrorType.CONNECT_TIMEOUT == e.type) {
      EasyLoading.dismiss(animation: true);
      print('case 1');
      print(
          "Server is not reachable. Please verify your internet connection and try again");
    } else if (DioErrorType.RESPONSE == e.type) {
      print('case 2');
      print("Server reachable. Error in resposne");

      EasyLoading.dismiss(animation: true);
      Utils().alert().showAlertMessage(
          title: '${e.response.data['content']['message'].toString()}', isSuccess: false);
    } else if (DioErrorType.DEFAULT == e.type) {
      if (e.message.contains('SocketException')) {
        print("Network error");
        print('case 3');
        EasyLoading.dismiss(animation: true);

        Utils().alert().showAlertMessage(
          title: 'networkError',
          isSuccess: false,
        );
      }
    } else {
      EasyLoading.dismiss(animation: true);
      print('case 4');
      print("Problem connecting to the server. Please try again.");
    }
  }



}
