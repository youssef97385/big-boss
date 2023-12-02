// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../core/common/domain/entites/generic_entity.dart' as _i15;
import '../../features/home_page/presentation/widgets/home_page.dart' as _i10;
import '../../features/login/presentation/widgets/login_page.dart' as _i2;
import '../../features/main/main_page.dart' as _i9;
import '../../features/menu_page/presentation/widgets/menu_page.dart' as _i8;
import '../../features/orders_page/presentation/order_page.dart' as _i11;
import '../../features/product_page/presentation/widgets/products_page.dart'
    as _i7;
import '../../features/products_list/data/models/products_categories_enum.dart'
    as _i14;
import '../../features/products_list/domain/entiities/product_endtity.dart'
    as _i16;
import '../../features/products_list/presentation/widgets/products_page.dart'
    as _i4;
import '../../features/register/presentation/widgets/register_page.dart' as _i3;
import '../../features/shopping_cart/presentation/widgets/cart_page.dart'
    as _i6;
import '../../features/splash/splash_page.dart' as _i1;
import '../../features/sub_categories/presentation/sub_categories_page.dart'
    as _i5;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    SplashAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginPageAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    RegisterPageAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterPage(),
      );
    },
    ProductsPageAppRouter.name: (routeData) {
      final args = routeData.argsAs<ProductsPageAppRouterArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.ProductsPage(
          key: args.key,
          id: args.id,
          productCatsEnum: args.productCatsEnum,
        ),
      );
    },
    SubCategoriesPageAppRouter.name: (routeData) {
      final args = routeData.argsAs<SubCategoriesPageAppRouterArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SubCategoriesPage(
          key: args.key,
          subCats: args.subCats,
          catName: args.catName,
        ),
      );
    },
    CartPageAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.CartPage(),
      );
    },
    ProductScreenAppRouter.name: (routeData) {
      final args = routeData.argsAs<ProductScreenAppRouterArgs>(
          orElse: () => const ProductScreenAppRouterArgs());
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ProductScreen(
          key: args.key,
          productEntity: args.productEntity,
        ),
      );
    },
    MenuPageAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.MenuPage(),
      );
    },
    MainAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.MainPage(),
      );
    },
    HomePageAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.HomePage(),
      );
    },
    OrderPageAppRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.OrderPage(),
        maintainState: false,
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          SplashAppRouter.name,
          path: '/',
        ),
        _i12.RouteConfig(
          LoginPageAppRouter.name,
          path: 'loginPage',
        ),
        _i12.RouteConfig(
          RegisterPageAppRouter.name,
          path: 'RegisterPage',
        ),
        _i12.RouteConfig(
          ProductsPageAppRouter.name,
          path: 'ProductsPage',
        ),
        _i12.RouteConfig(
          SubCategoriesPageAppRouter.name,
          path: 'SubCategoriesPage',
        ),
        _i12.RouteConfig(
          CartPageAppRouter.name,
          path: 'CartPage',
        ),
        _i12.RouteConfig(
          ProductScreenAppRouter.name,
          path: 'ProductScreen',
        ),
        _i12.RouteConfig(
          MenuPageAppRouter.name,
          path: 'MenuPage',
        ),
        _i12.RouteConfig(
          MainAppRouter.name,
          path: 'main',
          children: [
            _i12.RouteConfig(
              HomePageAppRouter.name,
              path: 'HomePage',
              parent: MainAppRouter.name,
            ),
            _i12.RouteConfig(
              CartPageAppRouter.name,
              path: 'CartPage',
              parent: MainAppRouter.name,
            ),
            _i12.RouteConfig(
              OrderPageAppRouter.name,
              path: 'OrderPage',
              parent: MainAppRouter.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashAppRouter extends _i12.PageRouteInfo<void> {
  const SplashAppRouter()
      : super(
          SplashAppRouter.name,
          path: '/',
        );

  static const String name = 'SplashAppRouter';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageAppRouter extends _i12.PageRouteInfo<void> {
  const LoginPageAppRouter()
      : super(
          LoginPageAppRouter.name,
          path: 'loginPage',
        );

  static const String name = 'LoginPageAppRouter';
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterPageAppRouter extends _i12.PageRouteInfo<void> {
  const RegisterPageAppRouter()
      : super(
          RegisterPageAppRouter.name,
          path: 'RegisterPage',
        );

  static const String name = 'RegisterPageAppRouter';
}

/// generated route for
/// [_i4.ProductsPage]
class ProductsPageAppRouter
    extends _i12.PageRouteInfo<ProductsPageAppRouterArgs> {
  ProductsPageAppRouter({
    _i13.Key? key,
    required int id,
    required _i14.ProductCatsEnum productCatsEnum,
  }) : super(
          ProductsPageAppRouter.name,
          path: 'ProductsPage',
          args: ProductsPageAppRouterArgs(
            key: key,
            id: id,
            productCatsEnum: productCatsEnum,
          ),
        );

  static const String name = 'ProductsPageAppRouter';
}

class ProductsPageAppRouterArgs {
  const ProductsPageAppRouterArgs({
    this.key,
    required this.id,
    required this.productCatsEnum,
  });

  final _i13.Key? key;

  final int id;

  final _i14.ProductCatsEnum productCatsEnum;

  @override
  String toString() {
    return 'ProductsPageAppRouterArgs{key: $key, id: $id, productCatsEnum: $productCatsEnum}';
  }
}

/// generated route for
/// [_i5.SubCategoriesPage]
class SubCategoriesPageAppRouter
    extends _i12.PageRouteInfo<SubCategoriesPageAppRouterArgs> {
  SubCategoriesPageAppRouter({
    _i13.Key? key,
    required List<_i15.GenericEntity> subCats,
    required String catName,
  }) : super(
          SubCategoriesPageAppRouter.name,
          path: 'SubCategoriesPage',
          args: SubCategoriesPageAppRouterArgs(
            key: key,
            subCats: subCats,
            catName: catName,
          ),
        );

  static const String name = 'SubCategoriesPageAppRouter';
}

class SubCategoriesPageAppRouterArgs {
  const SubCategoriesPageAppRouterArgs({
    this.key,
    required this.subCats,
    required this.catName,
  });

  final _i13.Key? key;

  final List<_i15.GenericEntity> subCats;

  final String catName;

  @override
  String toString() {
    return 'SubCategoriesPageAppRouterArgs{key: $key, subCats: $subCats, catName: $catName}';
  }
}

/// generated route for
/// [_i6.CartPage]
class CartPageAppRouter extends _i12.PageRouteInfo<void> {
  const CartPageAppRouter()
      : super(
          CartPageAppRouter.name,
          path: 'CartPage',
        );

  static const String name = 'CartPageAppRouter';
}

/// generated route for
/// [_i7.ProductScreen]
class ProductScreenAppRouter
    extends _i12.PageRouteInfo<ProductScreenAppRouterArgs> {
  ProductScreenAppRouter({
    _i13.Key? key,
    _i16.ProductEntity? productEntity,
  }) : super(
          ProductScreenAppRouter.name,
          path: 'ProductScreen',
          args: ProductScreenAppRouterArgs(
            key: key,
            productEntity: productEntity,
          ),
        );

  static const String name = 'ProductScreenAppRouter';
}

class ProductScreenAppRouterArgs {
  const ProductScreenAppRouterArgs({
    this.key,
    this.productEntity,
  });

  final _i13.Key? key;

  final _i16.ProductEntity? productEntity;

  @override
  String toString() {
    return 'ProductScreenAppRouterArgs{key: $key, productEntity: $productEntity}';
  }
}

/// generated route for
/// [_i8.MenuPage]
class MenuPageAppRouter extends _i12.PageRouteInfo<void> {
  const MenuPageAppRouter()
      : super(
          MenuPageAppRouter.name,
          path: 'MenuPage',
        );

  static const String name = 'MenuPageAppRouter';
}

/// generated route for
/// [_i9.MainPage]
class MainAppRouter extends _i12.PageRouteInfo<void> {
  const MainAppRouter({List<_i12.PageRouteInfo>? children})
      : super(
          MainAppRouter.name,
          path: 'main',
          initialChildren: children,
        );

  static const String name = 'MainAppRouter';
}

/// generated route for
/// [_i10.HomePage]
class HomePageAppRouter extends _i12.PageRouteInfo<void> {
  const HomePageAppRouter()
      : super(
          HomePageAppRouter.name,
          path: 'HomePage',
        );

  static const String name = 'HomePageAppRouter';
}

/// generated route for
/// [_i11.OrderPage]
class OrderPageAppRouter extends _i12.PageRouteInfo<void> {
  const OrderPageAppRouter()
      : super(
          OrderPageAppRouter.name,
          path: 'OrderPage',
        );

  static const String name = 'OrderPageAppRouter';
}
