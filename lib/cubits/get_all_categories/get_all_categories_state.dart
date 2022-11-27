part of 'get_all_categories_cubit.dart';

@immutable
abstract class GetAllCategoriesState {}

class GetAllCategoriesInitial extends GetAllCategoriesState {}

class GetAllCategoriesLoading extends GetAllCategoriesState {}

class GetAllCategoriesSucces extends GetAllCategoriesState {
  GetAllCategoriesSucces({required this.allCategories});
  final List<String> allCategories;
}

class GetAllCategoriesError extends GetAllCategoriesState {
  final String error;
  GetAllCategoriesError({required this.error});
}
