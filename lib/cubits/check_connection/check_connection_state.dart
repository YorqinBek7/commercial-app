part of 'check_connection_cubit.dart';

@immutable
abstract class CheckConnectionState {}

class CheckConnectionInitial extends CheckConnectionState {}

class CheckConnectionNone extends CheckConnectionState {}

class CheckConnectionInternet extends CheckConnectionState {}
