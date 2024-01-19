import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_master_course/src/component/user_info.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';

class UserListPageSetState extends StatefulWidget {
  const UserListPageSetState({super.key});

  @override
  State<UserListPageSetState> createState() => _UserListPageSetStateState();
}

class _UserListPageSetStateState extends State<UserListPageSetState> {
  late Dio _dio;
  ScrollController scrollController = ScrollController();
  int nextPage = -1;
  late UserInfoResult userInfoResult;

  Future<UserInfoResult> _loadUserList() async {
    final result = await _dio.get('api', queryParameters: {
      "results": 10,
      "seed": 'seed',
      'page': userInfoResult.currentPage,
    });
    userInfoResult = userInfoResult.copyWithFromJson(result.data);
    return userInfoResult;
  }

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
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    userInfoResult = const UserInfoResult(currentPage: 0, userInfoList: []);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent * 0.7 <=
              scrollController.offset &&
          nextPage != userInfoResult.currentPage) {
        nextPage = userInfoResult.currentPage;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState 상태관리'),
      ),
      body: FutureBuilder(
        future: _loadUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _error();
          }
          if (snapshot.hasData) {
            return _userListWidget(snapshot.data!.userInfoList);
          }
          return _loading();
        },
      ),
    );
  }
}
