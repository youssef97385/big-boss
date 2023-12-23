import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/slides_bloc/slides_cubit.dart';
import 'package:bigboss/src/features/shopping_cart/presentation/logic/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/constants/const.dart';

import '../../features/address/logic/address_cubit.dart';
import '../../features/order_feature/bloc/order_cubit.dart';
import '../../injection.dart';
import '../logic/app_bloc.dart';
import '../logic/app_settings.dart';
import '../logic/app_state.dart';
import '../routes/router.gr.dart';
import '../routes/router_observer.dart';
import '../theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //! most called here to set the selected language other parts in the app depend on it.
    serviceLocator<AppSettings>().changeSelectedLanguage(context.locale);
    //!

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => serviceLocator<AppBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SlidesCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CartCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<OrderCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AddressCubit>(),

        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          final int? themeID =
              2; //! Force select light mode , dynamic select => serviceLocator<AppSettings>().themeID;

          //! most called here to set the selected theme mode other parts in the app depend on it.
          serviceLocator<AppSettings>().themeID = themeID ?? 0;
          //!

          return MaterialApp.router(
            builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: kWebBG),
            ),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: serviceLocator<AppSettings>()
                .selectedThemeModeData
                .themeModeData,
            darkTheme: AppTheme().getDarkThemeData(),
            theme: AppTheme().getLightThemeData(),
            routerDelegate: AutoRouterDelegate(
              serviceLocator<AppRouter>(),
              // navigatorObservers: () => [serviceLocator<RouterObserver>()],
            ),
            routeInformationParser:
                serviceLocator<AppRouter>().defaultRouteParser(),
          );
        },
      ),
    );
  }
}
