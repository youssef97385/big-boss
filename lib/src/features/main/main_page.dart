import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/routes/router.gr.dart';
import '../../core/common/widgets/app_bar_view.dart';
import '../../core/constants/const.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          return true;
        } else {
          context.router.navigate(MainAppRouter());
          return false;
        }
      },
      child: AutoTabsScaffold(
        extendBody: false,
        routes: const [
          HomePageAppRouter(),
          OrderPageAppRouter(),
          CartPageAppRouter(),
        ],
        appBarBuilder: (_, tabsRouter) => const PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: AppBarView(
            appBarTitle: '',
          ),
        ),
        bottomNavigationBuilder: (_, tabsRouter) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
            child: SizedBox(
              height: 74,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: BottomNavigationBar(
                  currentIndex: currentIndex = tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.home),
                      label: "Home".tr(),
                      tooltip: '',
                      activeIcon: const Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.shopify_sharp),
                      label: 'Orders'.tr(),
                      tooltip: '',
                      activeIcon: const Icon(Icons.shopify_sharp),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.shopping_cart),
                      label: 'Cart'.tr(),
                      tooltip: '',
                      activeIcon: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
