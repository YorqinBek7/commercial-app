part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterDecs extends CounterState {}

class CounterIns extends CounterState {}
