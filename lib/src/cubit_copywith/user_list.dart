import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_master_course/src/component/user_info.dart';
import 'package:flutter_bloc_master_course/src/cubit_copywith/user_list_cubit_copywith.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';

class UserListForCubitCopyWith extends StatefulWidget {
  const UserListForCubitCopyWith({super.key});

  @override
  State<UserListForCubitCopyWith> createState() =>
      _UserListForCubitCopyWithState();
}

class _UserListForCubitCopyWithState extends State<UserListForCubitCopyWith> {
  ScrollController scrollController = ScrollController();

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _error() {
    return const Center(child: Text('오류 발생'));
  }

  Widget _userListWidget(List<UserInfo> userInfoList) {
    return ListView.separated(
      controller: scrollController,
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
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent - 200 <=
          scrollController.offset) {
        context.read<UserListCubitCopyWith>().loadUserList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cubit copyWith 상태관리'),
      ),
      body: BlocBuilder<UserListCubitCopyWith, UserListCubitState>(
        builder: (context, state) {
          switch (state.status) {
            case UserListCubitStatus.init:
            case UserListCubitStatus.loading:
            case UserListCubitStatus.loaded:
              return _userListWidget(state.userInfoResult.userInfoList);
            case UserListCubitStatus.error:
              return _error();
          }
        },
      ),
    );
  }
}
