part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductItem> products;
  ProductsSuccess({required this.products});
}

class ProductsError extends ProductsState {
  final String error;
  ProductsError({required this.error});
}
