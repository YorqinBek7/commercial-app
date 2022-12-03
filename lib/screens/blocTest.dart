import 'dart:developer';

import 'package:commercial_app/cubits/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocTest extends StatelessWidget {
  const BlocTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext _) {
          return CounterCubit();
        },
        child: View());
  }
}

class View extends StatelessWidget {
  const View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        BlocBuilder<CounterCubit, int>(
          builder: (BuildContext context, state) {
            return Center(
              child: Text(state.toString()),
            );
          },
        ),
        TextButton(
          onPressed: () {
            context.read<CounterCubit>().inc();
          },
          child: Text("+"),
        )
      ]),
    );
  }
}
