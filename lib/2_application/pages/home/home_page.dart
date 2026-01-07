import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/2_application/core/page_config.dart';
import 'package:flutter_to_do_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:flutter_to_do_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:flutter_to_do_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:flutter_to_do_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:flutter_to_do_app/2_application/pages/overview/overview_page.dart';
import 'package:flutter_to_do_app/2_application/pages/settings/settings_page.dart';
import 'package:go_router/go_router.dart';

class HomePageProvider extends StatelessWidget {
  final String tab;
  const HomePageProvider({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationTodoCubit>(
      create: (context) => NavigationTodoCubit(),
      child: HomePage(tab: tab),
    );
  }
}

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
        child: BlocListener<NavigationTodoCubit, NavigationTodoState>(
          listenWhen: (previous, current) => previous.isSecondaryBodyDisplayed != current.isSecondaryBodyDisplayed,
          listener: (context, state) {
            if(context.canPop() && (state.isSecondaryBodyDisplayed == false)){
              context.pop();
            } 
          },
          child: AdaptiveLayout(
            primaryNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: Key('primary-navigation-medium'),
                  builder: (context) => AdaptiveScaffold.standardNavigationRail(
                    leading: IconButton(
                      onPressed: () {
                        context.pushNamed(
                          CreateTodoCollectionPage.pageConfig.name,
                        );
                      },
                      icon: Icon(CreateTodoCollectionPage.pageConfig.icon),
                      tooltip: 'Create Collection',
                    ),
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
                  builder: widget.index != 1
                      ? null
                      : (_) =>
                            BlocBuilder<
                              NavigationTodoCubit,
                              NavigationTodoState
                            >(
                              builder: (context, state) {
                                final selectedId = state.selectedCollectionId;
                                final isSecondaryBodyDisplayed = Breakpoints
                                    .mediumAndUp
                                    .isActive(context);

                                context
                                    .read<NavigationTodoCubit>()
                                    .secondaryBodyDisplayChanged(
                                      isDisplayed: isSecondaryBodyDisplayed,
                                    );
                                if (selectedId == null) {
                                  return Center(
                                    child: Text('No Collection Selected'),
                                  );
                                }

                                return TodoDetailPageProvider(
                                  key: Key(selectedId.value),
                                  collectionId: selectedId,
                                );
                              },
                            ),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onTapHandleNavigationDestination(BuildContext context, int index) =>
      //context.go('/home/${HomePage.tabs[index].name}');
      context.goNamed(
        HomePage.pageConfig.name,
        pathParameters: {'tab': HomePage.tabs[index].name},
      );
}
