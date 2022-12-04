import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_user_info_state.dart';

enum UserInfo {
  changed,
  notChanged,
}

class ChangeUserInfoCubit extends Cubit<ChangeUserInfoState> {
  ChangeUserInfoCubit()
      : super(
          const ChangeUserInfoState(
              name: "", photoURL: null, userInfo: UserInfo.notChanged),
        );
  String name = "";
  String imageUrl = "asd";
  void updateUserName({
    required String nameUser,
  }) {
    name = nameUser;

    emit(state.copyWith(userInfo: UserInfo.notChanged));
    emit(state.copyWith(
        name: name, photoURL: imageUrl, userInfo: UserInfo.changed));
    emit(state.copyWith(userInfo: UserInfo.notChanged));
  }

  void updateUserImage({required String image}) {
    imageUrl = image;
    log(imageUrl);
    emit(state.copyWith(userInfo: UserInfo.notChanged));
    emit(state.copyWith(
        name: name, photoURL: imageUrl, userInfo: UserInfo.changed));
    emit(state.copyWith(userInfo: UserInfo.notChanged));
  }
}
