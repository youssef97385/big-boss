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
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i27;

import '../../core/common/domain/entites/generic_entity.dart' as _i24;
import '../../features/address/data/models/address_model.dart' as _i28;
import '../../features/address/widget/address_details_page.dart' as _i14;
import '../../features/address/widget/addresses_list.dart' as _i13;
import '../../features/address/widget/map_picker.dart' as _i11;
import '../../features/home_page/presentation/widgets/home_page.dart' as _i18;
import '../../features/login/presentation/widgets/login_page.dart' as _i2;
import '../../features/main/main_page.dart' as _i17;
import '../../features/menu_page/presentation/widgets/menu_page.dart' as _i9;
import '../../features/notification_page/presentation/widgets/notification_page.dart'
    as _i4;
import '../../features/offers/domain/offer_entity.dart' as _i29;
import '../../features/offers/presentation/widgets/offer_products_page.dart'
    as _i16;
import '../../features/order_feature/modles/order_model.dart' as _i26;
import '../../features/orders_page/presentation/order_detail_page.dart' as _i12;
import '../../features/orders_page/presentation/order_page.dart' as _i19;
import '../../features/otp-verifivation/presentation/widgets/verify_otp_screen.dart'
    as _i10;
import '../../features/product_page/presentation/widgets/products_page.dart'
    as _i8;
import '../../features/products_list/data/models/products_categories_enum.dart'
    as _i23;
import '../../features/products_list/domain/entiities/product_endtity.dart'
    as _i25;
import '../../features/products_list/presentation/widgets/products_page.dart'
    as _i5;
import '../../features/register/presentation/widgets/register_page.dart' as _i3;
import '../../features/search_page/search_page.dart' as _i20;
import '../../features/shopping_cart/presentation/widgets/cart_page.dart'
    as _i7;
import '../../features/shopping_cart/presentation/widgets/order_summary_page.dart'
    as _i15;
import '../../features/splash/splash_page.dart' as _i1;
import '../../features/sub_categories/presentation/sub_categories_page.dart'
    as _i6;

class AppRouter extends _i21.RootStackRouter {
  AppRouter([_i22.GlobalKey<_i22.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    SplashAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginPageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    RegisterPageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterPage(),
      );
    },
    NotificationPageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.NotificationPage(),
      );
    },
    ProductsPageAppRouter.name: (routeData) {
      final args = routeData.argsAs<ProductsPageAppRouterArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ProductsPage(
          key: args.key,
          id: args.id,
          productCatsEnum: args.productCatsEnum,
        ),
      );
    },
    SubCategoriesPageAppRouter.name: (routeData) {
      final args = routeData.argsAs<SubCategoriesPageAppRouterArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SubCategoriesPage(
          key: args.key,
          subCats: args.subCats,
          catName: args.catName,
        ),
      );
    },
    CartPageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.CartPage(),
      );
    },
    ProductScreenAppRouter.name: (routeData) {
      final args = routeData.argsAs<ProductScreenAppRouterArgs>(
          orElse: () => const ProductScreenAppRouterArgs());
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.ProductScreen(
          key: args.key,
          productEntity: args.productEntity,
        ),
      );
    },
    MenuPageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.MenuPage(),
      );
    },
    VerifyOtpScreenAppRouter.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpScreenAppRouterArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.VerifyOtpScreen(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    MapPickerAppRouter.name: (routeData) {
      final args = routeData.argsAs<MapPickerAppRouterArgs>(
          orElse: () => const MapPickerAppRouterArgs());
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.MapPicker(key: args.key),
      );
    },
    OrderDetailPageAppRouter.name: (routeData) {
      final args = routeData.argsAs<OrderDetailPageAppRouterArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.OrderDetailPage(
          key: args.key,
          orderModel: args.orderModel,
        ),
      );
    },
    AddressListAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.AddressList(),
      );
    },
    AddressDetailsPageAppRouter.name: (routeData) {
      final args = routeData.argsAs<AddressDetailsPageAppRouterArgs>(
          orElse: () => const AddressDetailsPageAppRouterArgs());
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.AddressDetailsPage(
          key: args.key,
          latLng: args.latLng,
        ),
      );
    },
    OrderSummaryAppRouter.name: (routeData) {
      final args = routeData.argsAs<OrderSummaryAppRouterArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.OrderSummary(
          key: args.key,
          addressModel: args.addressModel,
        ),
      );
    },
    OfferProductsPageAppRouter.name: (routeData) {
      final args = routeData.argsAs<OfferProductsPageAppRouterArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.OfferProductsPage(
          key: args.key,
          offerId: args.offerId,
          offerEntity: args.offerEntity,
        ),
      );
    },
    MainAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.MainPage(),
      );
    },
    HomePageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.HomePage(),
      );
    },
    OrderPageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.OrderPage(),
        maintainState: false,
      );
    },
    SearchPageAppRouter.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.SearchPage(),
      );
    },
  };

  @override
  List<_i21.RouteConfig> get routes => [
        _i21.RouteConfig(
          SplashAppRouter.name,
          path: '/',
        ),
        _i21.RouteConfig(
          LoginPageAppRouter.name,
          path: 'loginPage',
        ),
        _i21.RouteConfig(
          RegisterPageAppRouter.name,
          path: 'RegisterPage',
        ),
        _i21.RouteConfig(
          NotificationPageAppRouter.name,
          path: 'NotificationPage',
        ),
        _i21.RouteConfig(
          ProductsPageAppRouter.name,
          path: 'ProductsPage',
        ),
        _i21.RouteConfig(
          SubCategoriesPageAppRouter.name,
          path: 'SubCategoriesPage',
        ),
        _i21.RouteConfig(
          CartPageAppRouter.name,
          path: 'CartPage',
        ),
        _i21.RouteConfig(
          ProductScreenAppRouter.name,
          path: 'ProductScreen',
        ),
        _i21.RouteConfig(
          MenuPageAppRouter.name,
          path: 'MenuPage',
        ),
        _i21.RouteConfig(
          VerifyOtpScreenAppRouter.name,
          path: 'VerifyOtpScreen',
        ),
        _i21.RouteConfig(
          MapPickerAppRouter.name,
          path: 'MapPicker',
        ),
        _i21.RouteConfig(
          OrderDetailPageAppRouter.name,
          path: 'OrderDetailPage',
        ),
        _i21.RouteConfig(
          AddressListAppRouter.name,
          path: 'AddressList',
        ),
        _i21.RouteConfig(
          AddressDetailsPageAppRouter.name,
          path: 'AddressDetailsPage',
        ),
        _i21.RouteConfig(
          OrderSummaryAppRouter.name,
          path: 'OrderSummary',
        ),
        _i21.RouteConfig(
          OfferProductsPageAppRouter.name,
          path: 'OfferProductsPage',
        ),
        _i21.RouteConfig(
          MainAppRouter.name,
          path: 'main',
          children: [
            _i21.RouteConfig(
              HomePageAppRouter.name,
              path: 'HomePage',
              parent: MainAppRouter.name,
            ),
            _i21.RouteConfig(
              CartPageAppRouter.name,
              path: 'CartPage',
              parent: MainAppRouter.name,
            ),
            _i21.RouteConfig(
              OrderPageAppRouter.name,
              path: 'OrderPage',
              parent: MainAppRouter.name,
            ),
            _i21.RouteConfig(
              SearchPageAppRouter.name,
              path: 'SearchPage',
              parent: MainAppRouter.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashAppRouter extends _i21.PageRouteInfo<void> {
  const SplashAppRouter()
      : super(
          SplashAppRouter.name,
          path: '/',
        );

  static const String name = 'SplashAppRouter';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageAppRouter extends _i21.PageRouteInfo<void> {
  const LoginPageAppRouter()
      : super(
          LoginPageAppRouter.name,
          path: 'loginPage',
        );

  static const String name = 'LoginPageAppRouter';
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterPageAppRouter extends _i21.PageRouteInfo<void> {
  const RegisterPageAppRouter()
      : super(
          RegisterPageAppRouter.name,
          path: 'RegisterPage',
        );

  static const String name = 'RegisterPageAppRouter';
}

/// generated route for
/// [_i4.NotificationPage]
class NotificationPageAppRouter extends _i21.PageRouteInfo<void> {
  const NotificationPageAppRouter()
      : super(
          NotificationPageAppRouter.name,
          path: 'NotificationPage',
        );

  static const String name = 'NotificationPageAppRouter';
}

/// generated route for
/// [_i5.ProductsPage]
class ProductsPageAppRouter
    extends _i21.PageRouteInfo<ProductsPageAppRouterArgs> {
  ProductsPageAppRouter({
    _i22.Key? key,
    required int id,
    required _i23.ProductCatsEnum productCatsEnum,
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

  final _i22.Key? key;

  final int id;

  final _i23.ProductCatsEnum productCatsEnum;

  @override
  String toString() {
    return 'ProductsPageAppRouterArgs{key: $key, id: $id, productCatsEnum: $productCatsEnum}';
  }
}

/// generated route for
/// [_i6.SubCategoriesPage]
class SubCategoriesPageAppRouter
    extends _i21.PageRouteInfo<SubCategoriesPageAppRouterArgs> {
  SubCategoriesPageAppRouter({
    _i22.Key? key,
    required List<_i24.GenericEntity> subCats,
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

  final _i22.Key? key;

  final List<_i24.GenericEntity> subCats;

  final String catName;

  @override
  String toString() {
    return 'SubCategoriesPageAppRouterArgs{key: $key, subCats: $subCats, catName: $catName}';
  }
}

/// generated route for
/// [_i7.CartPage]
class CartPageAppRouter extends _i21.PageRouteInfo<void> {
  const CartPageAppRouter()
      : super(
          CartPageAppRouter.name,
          path: 'CartPage',
        );

  static const String name = 'CartPageAppRouter';
}

/// generated route for
/// [_i8.ProductScreen]
class ProductScreenAppRouter
    extends _i21.PageRouteInfo<ProductScreenAppRouterArgs> {
  ProductScreenAppRouter({
    _i22.Key? key,
    _i25.ProductEntity? productEntity,
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

  final _i22.Key? key;

  final _i25.ProductEntity? productEntity;

  @override
  String toString() {
    return 'ProductScreenAppRouterArgs{key: $key, productEntity: $productEntity}';
  }
}

/// generated route for
/// [_i9.MenuPage]
class MenuPageAppRouter extends _i21.PageRouteInfo<void> {
  const MenuPageAppRouter()
      : super(
          MenuPageAppRouter.name,
          path: 'MenuPage',
        );

  static const String name = 'MenuPageAppRouter';
}

/// generated route for
/// [_i10.VerifyOtpScreen]
class VerifyOtpScreenAppRouter
    extends _i21.PageRouteInfo<VerifyOtpScreenAppRouterArgs> {
  VerifyOtpScreenAppRouter({
    _i22.Key? key,
    required String phoneNumber,
  }) : super(
          VerifyOtpScreenAppRouter.name,
          path: 'VerifyOtpScreen',
          args: VerifyOtpScreenAppRouterArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
        );

  static const String name = 'VerifyOtpScreenAppRouter';
}

class VerifyOtpScreenAppRouterArgs {
  const VerifyOtpScreenAppRouterArgs({
    this.key,
    required this.phoneNumber,
  });

  final _i22.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'VerifyOtpScreenAppRouterArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i11.MapPicker]
class MapPickerAppRouter extends _i21.PageRouteInfo<MapPickerAppRouterArgs> {
  MapPickerAppRouter({_i22.Key? key})
      : super(
          MapPickerAppRouter.name,
          path: 'MapPicker',
          args: MapPickerAppRouterArgs(key: key),
        );

  static const String name = 'MapPickerAppRouter';
}

class MapPickerAppRouterArgs {
  const MapPickerAppRouterArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'MapPickerAppRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.OrderDetailPage]
class OrderDetailPageAppRouter
    extends _i21.PageRouteInfo<OrderDetailPageAppRouterArgs> {
  OrderDetailPageAppRouter({
    _i22.Key? key,
    required _i26.OrderModel orderModel,
  }) : super(
          OrderDetailPageAppRouter.name,
          path: 'OrderDetailPage',
          args: OrderDetailPageAppRouterArgs(
            key: key,
            orderModel: orderModel,
          ),
        );

  static const String name = 'OrderDetailPageAppRouter';
}

class OrderDetailPageAppRouterArgs {
  const OrderDetailPageAppRouterArgs({
    this.key,
    required this.orderModel,
  });

  final _i22.Key? key;

  final _i26.OrderModel orderModel;

  @override
  String toString() {
    return 'OrderDetailPageAppRouterArgs{key: $key, orderModel: $orderModel}';
  }
}

/// generated route for
/// [_i13.AddressList]
class AddressListAppRouter extends _i21.PageRouteInfo<void> {
  const AddressListAppRouter()
      : super(
          AddressListAppRouter.name,
          path: 'AddressList',
        );

  static const String name = 'AddressListAppRouter';
}

/// generated route for
/// [_i14.AddressDetailsPage]
class AddressDetailsPageAppRouter
    extends _i21.PageRouteInfo<AddressDetailsPageAppRouterArgs> {
  AddressDetailsPageAppRouter({
    _i22.Key? key,
    _i27.LatLng? latLng,
  }) : super(
          AddressDetailsPageAppRouter.name,
          path: 'AddressDetailsPage',
          args: AddressDetailsPageAppRouterArgs(
            key: key,
            latLng: latLng,
          ),
        );

  static const String name = 'AddressDetailsPageAppRouter';
}

class AddressDetailsPageAppRouterArgs {
  const AddressDetailsPageAppRouterArgs({
    this.key,
    this.latLng,
  });

  final _i22.Key? key;

  final _i27.LatLng? latLng;

  @override
  String toString() {
    return 'AddressDetailsPageAppRouterArgs{key: $key, latLng: $latLng}';
  }
}

/// generated route for
/// [_i15.OrderSummary]
class OrderSummaryAppRouter
    extends _i21.PageRouteInfo<OrderSummaryAppRouterArgs> {
  OrderSummaryAppRouter({
    _i22.Key? key,
    required _i28.AddressModel addressModel,
  }) : super(
          OrderSummaryAppRouter.name,
          path: 'OrderSummary',
          args: OrderSummaryAppRouterArgs(
            key: key,
            addressModel: addressModel,
          ),
        );

  static const String name = 'OrderSummaryAppRouter';
}

class OrderSummaryAppRouterArgs {
  const OrderSummaryAppRouterArgs({
    this.key,
    required this.addressModel,
  });

  final _i22.Key? key;

  final _i28.AddressModel addressModel;

  @override
  String toString() {
    return 'OrderSummaryAppRouterArgs{key: $key, addressModel: $addressModel}';
  }
}

/// generated route for
/// [_i16.OfferProductsPage]
class OfferProductsPageAppRouter
    extends _i21.PageRouteInfo<OfferProductsPageAppRouterArgs> {
  OfferProductsPageAppRouter({
    _i22.Key? key,
    required int offerId,
    required _i29.OfferEntity offerEntity,
  }) : super(
          OfferProductsPageAppRouter.name,
          path: 'OfferProductsPage',
          args: OfferProductsPageAppRouterArgs(
            key: key,
            offerId: offerId,
            offerEntity: offerEntity,
          ),
        );

  static const String name = 'OfferProductsPageAppRouter';
}

class OfferProductsPageAppRouterArgs {
  const OfferProductsPageAppRouterArgs({
    this.key,
    required this.offerId,
    required this.offerEntity,
  });

  final _i22.Key? key;

  final int offerId;

  final _i29.OfferEntity offerEntity;

  @override
  String toString() {
    return 'OfferProductsPageAppRouterArgs{key: $key, offerId: $offerId, offerEntity: $offerEntity}';
  }
}

/// generated route for
/// [_i17.MainPage]
class MainAppRouter extends _i21.PageRouteInfo<void> {
  const MainAppRouter({List<_i21.PageRouteInfo>? children})
      : super(
          MainAppRouter.name,
          path: 'main',
          initialChildren: children,
        );

  static const String name = 'MainAppRouter';
}

/// generated route for
/// [_i18.HomePage]
class HomePageAppRouter extends _i21.PageRouteInfo<void> {
  const HomePageAppRouter()
      : super(
          HomePageAppRouter.name,
          path: 'HomePage',
        );

  static const String name = 'HomePageAppRouter';
}

/// generated route for
/// [_i19.OrderPage]
class OrderPageAppRouter extends _i21.PageRouteInfo<void> {
  const OrderPageAppRouter()
      : super(
          OrderPageAppRouter.name,
          path: 'OrderPage',
        );

  static const String name = 'OrderPageAppRouter';
}

/// generated route for
/// [_i20.SearchPage]
class SearchPageAppRouter extends _i21.PageRouteInfo<void> {
  const SearchPageAppRouter()
      : super(
          SearchPageAppRouter.name,
          path: 'SearchPage',
        );

  static const String name = 'SearchPageAppRouter';
}
