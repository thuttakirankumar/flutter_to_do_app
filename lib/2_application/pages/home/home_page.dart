import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_to_do_app/2_application/core/page_config.dart';
import 'package:flutter_to_do_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:flutter_to_do_app/2_application/pages/overview/overview_page.dart';
import 'package:flutter_to_do_app/2_application/pages/settings/settings_page.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
    : index = tabs.indexWhere((element) => element.name == tab);

  static const pageConfig = PageConfig(icon: Icons.home_rounded, name: 'home');
  final int index;
  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
    SettingsPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) =>
            NavigationDestination(icon: Icon(page.icon), label: page.name),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: Key('primary-navigation-medium'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  selectedIndex: widget.index,
                  onDestinationSelected: (value) =>
                      _onTapHandleNavigationDestination(context, value),
                  destinations: destinations
                      .map(
                        (element) =>
                            AdaptiveScaffold.toRailDestination(element),
                      )
                      .toList(),
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: Key('primary-body'),
                builder: (_) => HomePage.tabs[widget.index].child,
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: Key('bottom-navigation-small'),
                builder: (context) =>
                    AdaptiveScaffold.standardBottomNavigationBar(
                      currentIndex: widget.index,
                      destinations: destinations,
                      onDestinationSelected: (value) =>
                          _onTapHandleNavigationDestination(context, value),
                    ),
              ),
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: Key('secondary-body'),
                builder: AdaptiveScaffold.emptyBuilder,
              ),
            },
          ),
        ),
      ),
    );
  }

  void _onTapHandleNavigationDestination(BuildContext context, int index) =>
      //context.go('/home/${HomePage.tabs[index].name}');
      context.goNamed(HomePage.pageConfig.name,
      pathParameters: {
        'tab': HomePage.tabs[index].name
      },
      );
}
