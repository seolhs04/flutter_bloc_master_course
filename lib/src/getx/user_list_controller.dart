import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';
import 'package:get/state_manager.dart';

class UserListController extends GetxController {
  late Dio _dio;
  ScrollController scrollController = ScrollController();
  int nextPage = -1;
  Rx<UserInfoResult> userInfoResult = UserInfoResult.init().obs;

  Future<void> _loadUserList() async {
    final result = await _dio.get('api', queryParameters: {
      "results": 10,
      "seed": 'seed',
      'page': userInfoResult.value.currentPage,
    });
    userInfoResult(userInfoResult.value.copyWithFromJson(result.data));
  }

  @override
  void onInit() {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent * 0.7 <=
              scrollController.offset &&
          nextPage != userInfoResult.value.currentPage) {
        nextPage = userInfoResult.value.currentPage;
        _loadUserList();
      }
    });
    _loadUserList();
    super.onInit();
  }
}
