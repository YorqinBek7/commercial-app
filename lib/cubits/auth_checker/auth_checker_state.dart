part of 'auth_checker_cubit.dart';

enum Auth {
  logged,
  signOut,
}

class AuthChecker extends Equatable {
  final User? user;
  final Auth? auth;
  const AuthChecker({
    this.user,
    this.auth,
  });
  AuthChecker copyWith({
    User? user,
    Auth? auth,
  }) =>
      AuthChecker(
        user: user ?? this.user,
        auth: auth ?? this.auth,
      );

  @override
  List<Object?> get props => [user, auth];
}
