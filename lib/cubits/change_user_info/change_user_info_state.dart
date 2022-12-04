part of 'change_user_info_cubit.dart';

class ChangeUserInfoState extends Equatable {
  const ChangeUserInfoState(
      {required this.name, this.photoURL, required this.userInfo});
  final String name;
  final String? photoURL;
  final UserInfo userInfo;

  ChangeUserInfoState copyWith({
    String? name,
    String? photoURL,
    UserInfo? userInfo,
  }) {
    return ChangeUserInfoState(
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object?> get props => [
        name,
        photoURL,
      ];
}
