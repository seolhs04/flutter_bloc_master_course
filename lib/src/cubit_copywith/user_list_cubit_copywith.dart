import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';

enum UserListCubitStatus { init, loading, loaded, error }

class UserListCubitCopyWith extends Cubit<UserListCubitState> {
  late Dio _dio;
  UserListCubitCopyWith() : super(UserListCubitState.init()) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    loadUserList();
  }

  loadUserList() async {
    try {
      if (state.status == UserListCubitStatus.loading ||
          state.status == UserListCubitStatus.error) {
        return;
      }
      emit(state.copyWith(status: UserListCubitStatus.loading));
      final result = await _dio.get('api', queryParameters: {
        "results": 10,
        "seed": 'seed',
        'page': state.userInfoResult.currentPage,
      });
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        state.copyWith(
          status: UserListCubitStatus.loaded,
          userInfoResult: state.userInfoResult.copyWithFromJson(result.data),
        ),
      );
    } catch (error) {
      emit(state.copyWith(
          status: UserListCubitStatus.error, errorMessage: error.toString()));
    }
  }
}

class UserListCubitState extends Equatable {
  final UserListCubitStatus status;
  final UserInfoResult userInfoResult;
  final String? errorMessage;

  const UserListCubitState({
    required this.status,
    required this.userInfoResult,
    this.errorMessage,
  });

  UserListCubitState.init()
      : this(
          status: UserListCubitStatus.init,
          userInfoResult: UserInfoResult.init(),
        );

  UserListCubitState copyWith({
    UserListCubitStatus? status,
    UserInfoResult? userInfoResult,
    String? errorMessage,
  }) {
    return UserListCubitState(
      status: status ?? this.status,
      userInfoResult: userInfoResult ?? this.userInfoResult,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, userInfoResult, errorMessage];
}
