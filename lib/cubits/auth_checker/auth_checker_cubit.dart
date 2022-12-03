import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_checker_state.dart';

class AuthCheckerCubit extends Cubit<AuthChecker> {
  AuthCheckerCubit()
      : super(
          AuthChecker(
            user: FirebaseAuth.instance.currentUser,
            auth: Auth.signOut,
          ),
        );
  void userChecker() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      emit(
        state.copyWith(
          user: event,
        ),
      );
      if (state.user == null) {
        emit(state.copyWith(auth: Auth.signOut));
      } else {
        emit(
          state.copyWith(
            auth: Auth.logged,
            user: FirebaseAuth.instance.currentUser,
          ),
        );
      }
    });
  }
}
