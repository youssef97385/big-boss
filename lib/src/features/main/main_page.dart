import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/widgets/image_view.dart';
import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:bigboss/src/core/constants/image_name.dart';
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
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.router.pop();
                        },
                        child: Icon(
                          Icons.close,
                          size: 30,
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      ImageNameHelper.getValue(
                        ImageName.logo,
                      ),
                      width: 60,
                      height: 60,
                    )
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                ListTile(
                  leading: SvgPicture.asset("assets/images/icons/location_icon.svg"),
                  title: TextView(
                    text: "Order tracking",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),


                ListTile(    trailing: Icon(Icons.keyboard_arrow_down_outlined,size: 30,),
                  leading: SvgPicture.asset("assets/images/icons/companies_icon.svg"),
                  title: TextView(
                    text: "Companies",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),  const SizedBox(
                  height: 12,
                ),

                ListTile(    trailing: Icon(Icons.keyboard_arrow_down_outlined,size: 30,),
                  leading: SvgPicture.asset("assets/images/icons/brands_icon.svg"),
                  title: TextView(
                    text: "Brands",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                ListTile(
                  trailing: Icon(Icons.keyboard_arrow_down_outlined,size: 30,),
                  leading: SvgPicture.asset("assets/images/icons/countries_icon.svg"),
                  title: TextView(
                    text: "Countries",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),



                ListTile(
                  trailing:  TextView(
                    text: "English",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                  leading: SvgPicture.asset("assets/images/icons/language_icon.svg"),
                  title: TextView(
                    text: "Language",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                ListTile(
                  leading: SvgPicture.asset("assets/images/icons/faq_icon.svg"),
                  title: TextView(
                    text: "FAQ's",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                ListTile(
                  leading: SvgPicture.asset("assets/images/icons/about_us_icon.svg"),
                  title: TextView(
                    text: "About us",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                ListTile(
                  leading: SvgPicture.asset("assets/images/icons/terms_icon.svg"),
                  title: TextView(
                    text: "Terms & conditions",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xff262626), fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
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
            customeOption: Row(
              children: [
                InkWell(
                  onTap: () {
                    context.router.push(NotificationPageAppRouter());
                  },
                  child: SvgPicture.asset(
                      "assets/images/icons/notification_icon.svg"),
                ),
                const SizedBox(
                  width: 12,
                ),
                Visibility(
                  visible: serviceLocator<DatabaseManager>().getData("token") !=
                      null,
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
                selectedIconTheme:
                    IconThemeData(color: Theme.of(context).colorScheme.primary),
                unselectedIconTheme: IconThemeData(color: Colors.grey[700]),
                selectedItemColor: Theme.of(context).colorScheme.primary,
                currentIndex: currentIndex = tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "Home".tr(),
                    tooltip: '',
                    activeIcon: Icon(
                      Icons.home,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopify_sharp),
                    label: 'Orders'.tr(),
                    tooltip: '',
                    activeIcon: Icon(
                      Icons.shopify_sharp,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    label: 'Cart'.tr(),
                    tooltip: '',
                    activeIcon: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    label: 'Search'.tr(),
                    tooltip: '',
                    activeIcon: Icon(
                      Icons.search,
                    ),
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
