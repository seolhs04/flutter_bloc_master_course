import 'package:flutter/material.dart';
import 'package:flutter_bloc_master_course/src/component/user_info.dart';
import 'package:flutter_bloc_master_course/src/getx/user_list_controller.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserListForGetX extends GetView<UserListController> {
  const UserListForGetX({super.key});

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _error() {
    return const Center(child: Text('오류 발생'));
  }

  Widget _userListWidget(List<UserInfo> userInfoList) {
    return ListView.separated(
      controller: controller.scrollController,
      itemBuilder: (context, index) {
        if (index == userInfoList.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return UserInfoWidget(userInfo: userInfoList[index]);
      },
      separatorBuilder: (context, index) => const Divider(color: Colors.grey),
      itemCount: userInfoList.length + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState 상태관리'),
      ),
      body: Obx(
        () => _userListWidget(controller.userInfoResult.value.userInfoList),
      ),
    );
  }
}
