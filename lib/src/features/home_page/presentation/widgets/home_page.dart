import 'package:bigboss/src/features/home_page/presentation/logic/accounts_cubit/accounts_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/categories_cubit/categories_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/countries_cubit/countries_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/new_products_cubit/new_products_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/slides_bloc/slides_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/widgets/accounts_widget.dart';
import 'package:bigboss/src/features/home_page/presentation/widgets/brands_widget.dart';
import 'package:bigboss/src/features/home_page/presentation/widgets/countries_widget.dart';
import 'package:bigboss/src/features/home_page/presentation/widgets/slides_widget.dart';
import 'package:bigboss/src/features/offers/presentation/widgets/offers_widget.dart';
import 'package:bigboss/src/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../offers/presentation/logic/offers_bloc.dart';
import 'categories_widget.dart';
import 'new_products_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          BlocProvider(
            create: (context) => serviceLocator<SlidesCubit>(),
            child: const SlidesWidget(),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocProvider(
            create: (context) => serviceLocator<OffersCubit>(),
            child: const OffersWidget(),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocProvider(
            create: (context) => serviceLocator<NewProductsCubit>(),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),child: const NewProductsWidget()),
          ),
          const SizedBox(
            height: 24,
          ),
          // BlocProvider(
          //   create: (context) => serviceLocator<CategoriesCubit>(),
          //   child: const CategoriesWidget(),
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          BlocProvider(
            create: (context) => serviceLocator<CountriesCubit>(),
            child:Container(
                width: double.infinity,
                color: const Color(0xFFF6F6F6),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 30),
                  child: CountriesWidget(),
                )),
          ),
          const SizedBox(
            height: 24,
          ),
          // BlocProvider(
          //   create: (context) => serviceLocator<AccountsCubit>(),
          //   child: const AccountsWidget(),
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          BlocProvider(
            create: (context) => serviceLocator<BrandsCubit>(),
            child: Container(
              width: double.infinity,
              color: const Color(0xFFF6F6F6),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 30),child: const BrandsWidget()),
          ),),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
