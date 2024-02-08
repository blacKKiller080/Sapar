import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wrap_architecture/src/core/extension/extensions.dart';
import 'package:flutter_wrap_architecture/src/core/resources/resources.dart';
import 'package:flutter_wrap_architecture/src/features/app/router/app_router.dart';
import 'package:flutter_wrap_architecture/src/features/app/widgets/custom/custom_tab_bar_widget.dart';

// ignore: unused_element
const _tag = 'Base';

class Base extends StatefulWidget {
  final int? initialTabIndex;

  const Base({
    super.key,
    this.initialTabIndex,
  });

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> with TickerProviderStateMixin {
  TabController? tabController;
  String accessToken = '';
  String refreshToken = '';
  bool hasExpiredToken = false;
  int previousIndex = 0;
  String? incomingUri;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: widget.initialTabIndex ?? 0,
      length: 4,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        MainRoute(),
        SecondRoute(),
        ThirdRoute(),
        BaseProfileTab(),
      ],
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      transitionBuilder: (context, child, animation) {
        return SafeArea(
          bottom: false,
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              // Text(incomingUri ?? 'not'),
              Expanded(child: child),
            ],
          ),
        );
      }, //////   IMPORTANT
      backgroundColor: AppColors.kGlobalBackground,
      bottomNavigationBuilder: (_, tabsRouter) {
        // tabsRouter.setActiveIndex(tabController!.index);
        return Padding(
          padding: EdgeInsets.only(bottom: Platform.isIOS ? 25.0 : 8.0, top: 7),
          child: TabBar(
            onTap: (value) {
              previousIndex = tabsRouter.previousIndex ?? 0;
              if (tabsRouter.activeIndex == value) {
                tabsRouter.popTop();
              } else {
                tabsRouter.setActiveIndex(value);
              }
            },
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            controller: tabController,
            labelPadding: EdgeInsets.zero,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            tabs: [
              CustomTabWidget(
                icon: 'assets/icons/main_tab.svg',
                activeIcon: 'assets/icons/main_tab.svg',
                title: context.localized.homeTab,
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 0,
              ),
              CustomTabWidget(
                icon: 'assets/icons/polices_tab.svg',
                activeIcon: 'assets/icons/polices_tab.svg',
                title: context.localized.secondTab,
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 1,
              ),
              CustomTabWidget(
                icon: 'assets/icons/insurance_tab.svg',
                activeIcon: 'assets/icons/insurance_tab.svg',
                title: context.localized.thirdTab,
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 2,
              ),
              CustomTabWidget(
                icon: 'assets/icons/profile_tab.svg',
                activeIcon: 'assets/icons/profile_tab.svg',
                title: context.localized.fourthTab,
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}
