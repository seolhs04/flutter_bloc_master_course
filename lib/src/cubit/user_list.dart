import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_master_course/src/component/user_info.dart';
import 'package:flutter_bloc_master_course/src/cubit/user_list_cubit_extends.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';

class UserListForCubitForExtends extends StatefulWidget {
  const UserListForCubitForExtends({super.key});

  @override
  State<UserListForCubitForExtends> createState() =>
      _UserListForCubitForExtendsState();
}

class _UserListForCubitForExtendsState
    extends State<UserListForCubitForExtends> {
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
        context.read<UserListCubitExtends>().loadUserList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cubit extends 상태관리'),
      ),
      body: BlocBuilder<UserListCubitExtends, UserListCubitState>(
        builder: (context, state) {
          if (state is ErrorUserListCubitState) {
            return _error();
          }
          if (state is LoadedUserListCubitState ||
              state is LoadingUserListCubitState) {
            return _userListWidget(state.userInfoResult.userInfoList);
          }
          return Container();
        },
      ),
    );
  }
}
