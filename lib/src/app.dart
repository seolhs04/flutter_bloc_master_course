import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_master_course/src/bloc/license_bloc.dart';
import 'package:flutter_bloc_master_course/src/bloc/product_bloc.dart';
import 'package:flutter_bloc_master_course/src/component/buy_btn.dart';
import 'package:flutter_bloc_master_course/src/component/loading.dart';
import 'package:flutter_bloc_master_course/src/component/lock_widget.dart';
import 'package:flutter_bloc_master_course/src/component/product_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc to Comunication'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DefaultItems(),
          const SizedBox(height: 50),
          _PayItems(),
        ],
      ),
      bottomNavigationBar: BuyBtn(
        onTap: () {
          context.read<LicenseBloc>().add(BuyLicenseEvent());
        },
      ),
    );
  }
}

class _DefaultItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            '기본 권한 아이템',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        const SizedBox(height: 20),
        if (state is LoadingProductState) const Loading(),
        if (state is LoadedProductState)
          ProductsWidget(
            items: List.generate(
              state.defaultItems?.length ?? 0,
              (index) => state.defaultItems![index],
            ),
          ),
      ],
    );
  }
}

class _PayItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            '유료 권한 아이템',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        const SizedBox(height: 20),
        if (state is LoadingProductState) const Loading(),
        if (state is LoadedProductState && state.payItems == null)
          const LockWidget(),
        if (state is LoadedProductState && state.payItems != null)
          ProductsWidget(
            items: List.generate(
              state.payItems?.length ?? 0,
              (index) => state.payItems![index],
            ),
          ),
      ],
    );
  }
}
