import 'package:flutter_bloc/flutter_bloc.dart';
part 'change_user_info_state.dart';

class ChangeUserInfoCubit extends Cubit<ChangeUserInfoState> {
  ChangeUserInfoCubit() : super(UserChangingState());

  void changeUserInfo({String? image, required String name}) {
    emit(UserChanged());
    emit(UserChangingState(image: image, name: name));
  }
}
