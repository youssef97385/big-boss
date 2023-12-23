import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/features/orders_page/presentation/order_page.dart';
import '../../features/address/widget/address_details_page.dart';
import '../../features/address/widget/addresses_list.dart';
import '../../features/address/widget/map_picker.dart';
import '../../features/home_page/presentation/widgets/home_page.dart';
import '../../features/intro/intro_page.dart';
import '../../features/login/presentation/widgets/login_page.dart';
import '../../features/main/main_page.dart';
import '../../features/menu_page/presentation/widgets/menu_page.dart';
import '../../features/otp-verifivation/presentation/widgets/verify_otp_screen.dart';
import '../../features/product_page/presentation/widgets/products_page.dart';
import '../../features/products_list/presentation/widgets/products_page.dart';
import '../../features/register/presentation/widgets/register_page.dart';
import '../../features/search_page/search_page.dart';
import '../../features/shopping_cart/presentation/widgets/cart_page.dart';
import '../../features/shopping_cart/presentation/widgets/order_summary_page.dart';
import '../../features/splash/splash_page.dart';
import '../../features/sub_categories/presentation/sub_categories_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      name: 'splashAppRouter',
      page: SplashPage,
    ),
    AutoRoute(
      path: 'loginPage',
      name: 'loginPageAppRouter',
      page: LoginPage,
    ),
    AutoRoute(
      path: 'RegisterPage',
      name: 'RegisterPageAppRouter',
      page: RegisterPage,
    ),
    AutoRoute(
      path: 'ProductsPage',
      name: 'ProductsPageAppRouter',
      page: ProductsPage,
    ),
    AutoRoute(
      path: 'SubCategoriesPage',
      name: 'SubCategoriesPageAppRouter',
      page: SubCategoriesPage,
    ),
    AutoRoute(
      path: 'CartPage',
      name: 'CartPageAppRouter',
      page: CartPage,
    ),
    AutoRoute(
      path: 'ProductScreen',
      name: 'ProductScreenAppRouter',
      page: ProductScreen,
    ),
    AutoRoute(
      path: 'MenuPage',
      name: 'MenuPageAppRouter',
      page: MenuPage,
    ),
    AutoRoute(
      path: 'VerifyOtpScreen',
      name: 'VerifyOtpScreenAppRouter',
      page: VerifyOtpScreen,
    ),
    AutoRoute(
      path: 'MapPicker',
      name: 'MapPickerAppRouter',
      page: MapPicker,
    ),
    AutoRoute(
      path: 'AddressList',
      name: 'AddressListAppRouter',
      page: AddressList,
    ),
    AutoRoute(
      path: 'AddressDetailsPage',
      name: 'AddressDetailsPageAppRouter',
      page: AddressDetailsPage,
    ), AutoRoute(
      path: 'OrderSummary',
      name: 'OrderSummaryAppRouter',
      page: OrderSummary,
    ),
    AutoRoute(
      path: 'main',
      name: 'mainAppRouter',
      page: MainPage,
      children: [
        AutoRoute(
          path: 'HomePage',
          name: 'HomePageAppRouter',
          page: HomePage,
        ),
        AutoRoute(
          path: 'CartPage',
          name: 'CartPageAppRouter',
          page: CartPage,
        ),
        AutoRoute(
            path: 'OrderPage',
            name: 'OrderPageAppRouter',
            page: OrderPage,
            maintainState: false),
        AutoRoute(
          path: 'SearchPage',
          name: 'SearchPageAppRouter',
          page: SearchPage,
        ),
      ],
    )
  ],
)
class $AppRouter {}
