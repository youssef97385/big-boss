import 'package:bigboss/src/core/common/widgets/text_view.dart';
import 'package:flutter/material.dart';

import '../../constants/const.dart';

class TabBarWidget extends StatelessWidget {
  final String firstTabTitle;
  final String secondTabTitle;
  final TabController tabController;

  const TabBarWidget({
    Key? key,
    required this.firstTabTitle,
    required this.secondTabTitle,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height:200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        color: kTabContainerColor,
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            14.0,
          ),
          color: Colors.white,
        ),
        indicatorPadding: EdgeInsets.all(4),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: [
          // first tab [you can add an icon using the icon property]
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Tab(
              child: TextView(
                text: firstTabTitle,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: kDarkGrayColor,
                    ),
              ),
            ),
          ),

          // second tab [you can add an icon using the icon property]
          Tab(
            child: TextView(
              text: secondTabTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
