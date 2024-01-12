import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/routes/router.gr.dart';
import '../../core/common/widgets/app_bar_view.dart';
import '../../core/constants/const.dart';
import '../../core/utils/managers/database/database_manager.dart';
import '../../injection.dart';

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
          SearchPageAppRouter(),
        ],
        appBarBuilder: (_, tabsRouter) => PreferredSize(
          preferredSize: Size(double.infinity, 64),
          child: AppBarView(
            appBarTitle: '',
            
            customeOption:
                Row(
                  children: [
                    
                    InkWell(
                        onTap: (){
                          context.router.push(NotificationPageAppRouter());
                        },
                        child: Icon(IconData(0xe44f, fontFamily: 'MaterialIcons'))),
                    const SizedBox(width: 12,),
                    Visibility(
                      visible: serviceLocator<DatabaseManager>().getData("token") != null,
                      child: InkWell(
                        onTap: () {
                          context.router.navigate(MenuPageAppRouter());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            (Icons.person),
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    
                        
                  ],
                ),
               
          ),
        ),
        bottomNavigationBuilder: (_, tabsRouter) {
          return Container(

            height: 95,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: BottomNavigationBar(
                  selectedIconTheme:IconThemeData(color:Theme.of(context).colorScheme.primary ),
                unselectedIconTheme: IconThemeData(color:Colors.grey[700] ),
                selectedItemColor: Theme.of(context).colorScheme.primary,
                currentIndex: currentIndex = tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.home,),
                    label: "Home".tr(),
                    tooltip: '',
                    activeIcon:  Icon(Icons.home,),
                  ),
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.shopify_sharp),
                    label: 'Orders'.tr(),
                    tooltip: '',
                    activeIcon:  Icon(Icons.shopify_sharp,),
                  ),
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.shopping_cart,),
                    label: 'Cart'.tr(),
                    tooltip: '',
                    activeIcon:  Icon(Icons.shopping_cart,),
                  ),
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.search,),
                    label: 'Search'.tr(),
                    tooltip: '',
                    activeIcon:  Icon(Icons.search,),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
