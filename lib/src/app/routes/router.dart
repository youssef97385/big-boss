import 'package:auto_route/auto_route.dart';
import '../../features/home_page/presentation/widgets/home_page.dart';
import '../../features/intro/intro_page.dart';
import '../../features/login/presentation/widgets/login_page.dart';
import '../../features/main/main_page.dart';
import '../../features/product_page/presentation/widgets/products_page.dart';
import '../../features/products_list/presentation/widgets/products_page.dart';
import '../../features/register/presentation/widgets/register_page.dart';
import '../../features/shopping_cart/presentation/widgets/cart_page.dart';
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
      ],
    )
  ],
)
class $AppRouter {}