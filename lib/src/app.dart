import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_master_course/src/cubit/user_list.dart';
import 'package:flutter_bloc_master_course/src/cubit/user_list_cubit_extends.dart';
import 'package:flutter_bloc_master_course/src/cubit_copywith/user_list.dart';
import 'package:flutter_bloc_master_course/src/cubit_copywith/user_list_cubit_copywith.dart';
import 'package:flutter_bloc_master_course/src/getx/user_list.dart';
import 'package:flutter_bloc_master_course/src/getx/user_list_controller.dart';
import 'package:flutter_bloc_master_course/src/set_state/user_list.dart';
import 'package:get/instance_manager.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserListPageSetState(),
                    ),
                  );
                },
                child: const Text('SetState 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Get.put(UserListController());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserListForGetX(),
                    ),
                  );
                },
                child: const Text('GetX 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => UserListCubitExtends(),
                        child: const UserListForCubitForExtends(),
                      ),
                    ),
                  );
                },
                child: const Text('Extends 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => UserListCubitCopyWith(),
                        child: const UserListForCubitCopyWith(),
                      ),
                    ),
                  );
                },
                child: const Text('CopyWith 상태관리')),
          ],
        ),
      ),
    );
  }
}
