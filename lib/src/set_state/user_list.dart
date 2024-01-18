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

  Future<UserInfoResult> _loadUserList() async {
    final result = await _dio.get('api', queryParameters: {
      "results": 10,
      "seed": 'seed',
      'page': 0,
    });
    return UserInfoResult.fromJson(result.data);
  }

  @override
  void initState() {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    super.initState();
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
            return const Center(child: Text('오류 발생'));
          }
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return UserInfoWidget(
                  userInfo: snapshot.data!.userInfoList[index],
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey),
              itemCount: snapshot.data!.userInfoList.length,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
