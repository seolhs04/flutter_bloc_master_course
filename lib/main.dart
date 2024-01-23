import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_master_course/src/app.dart';
import 'package:flutter_bloc_master_course/src/bloc/license_bloc.dart';
import 'package:flutter_bloc_master_course/src/bloc/product_bloc.dart';
import 'package:flutter_bloc_master_course/src/repository/license_repository.dart';
import 'package:flutter_bloc_master_course/src/repository/product_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => ProductRepository()),
            RepositoryProvider(create: (context) => LicenseRepository()),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProductBloc(
                  context.read<ProductRepository>(),
                  context.read<LicenseRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => LicenseBloc(
                  context.read<LicenseRepository>(),
                ),
              )
            ],
            child: const App(),
          )),
    );
  }
}
