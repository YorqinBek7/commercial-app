part of 'change_user_info_cubit.dart';

abstract class ChangeUserInfoState {}

class UserChangingState extends ChangeUserInfoState {
  String? image;
  String? name;
  UserChangingState({
    this.image,
    this.name,
  });
}

class UserChanged extends ChangeUserInfoState {}
