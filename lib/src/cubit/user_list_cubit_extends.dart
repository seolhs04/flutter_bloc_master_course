import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';

class UserListCubitExtends extends Cubit<UserListCubitState> {
  late Dio _dio;
  UserListCubitExtends() : super(InitUserListCubitState()) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    loadUserList();
  }

  loadUserList() async {
    try {
      if (state is LoadingUserListCubitState ||
          state is ErrorUserListCubitState) {
        return;
      }
      print(state.userInfoResult.currentPage);
      emit(LoadingUserListCubitState(userInfoResult: state.userInfoResult));
      final result = await _dio.get('api', queryParameters: {
        "results": 10,
        "seed": 'seed',
        'page': state.userInfoResult.currentPage,
      });
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        LoadedUserListCubitState(
          userInfoResult: state.userInfoResult.copyWithFromJson(result.data),
        ),
      );
    } catch (error) {
      emit(
        ErrorUserListCubitState(
          errorMessage: error.toString(),
          userInfoResult: state.userInfoResult,
        ),
      );
    }
  }
}

abstract class UserListCubitState extends Equatable {
  final UserInfoResult userInfoResult;
  const UserListCubitState({required this.userInfoResult});
}

// loading
// error
// loaded
// init

class InitUserListCubitState extends UserListCubitState {
  InitUserListCubitState() : super(userInfoResult: UserInfoResult.init());

  @override
  // TODO: implement props
  List<Object?> get props => [userInfoResult];
}

class LoadingUserListCubitState extends UserListCubitState {
  const LoadingUserListCubitState({required super.userInfoResult});

  @override
  // TODO: implement props
  List<Object?> get props => [userInfoResult];
}

class LoadedUserListCubitState extends UserListCubitState {
  const LoadedUserListCubitState({required super.userInfoResult});

  @override
  // TODO: implement props
  List<Object?> get props => [userInfoResult];
}

class ErrorUserListCubitState extends UserListCubitState {
  final String errorMessage;

  const ErrorUserListCubitState({
    required this.errorMessage,
    required super.userInfoResult,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage, userInfoResult];
}
