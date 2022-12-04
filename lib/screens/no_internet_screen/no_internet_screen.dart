import 'package:commercial_app/cubits/check_connection/check_connection_cubit.dart';
import 'package:commercial_app/cubits/get_all_categories/get_all_categories_cubit.dart';
import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<CheckConnectionCubit, CheckConnectionState>(
        listener: (context, state) {
          if (state is CheckConnectionInternet) {
            context.read<ProductsCubit>().getProductsList();
            context.read<GetAllCategoriesCubit>().getAllCategories();
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          body: Center(
            child: LottieBuilder.asset("assets/lotties/no_connection.json"),
          ),
        ),
      ),
    );
  }
}
