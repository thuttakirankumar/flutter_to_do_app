import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/2_application/core/go_router_observer.dart';
import 'package:flutter_to_do_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:flutter_to_do_app/2_application/pages/home/home_page.dart';
import 'package:flutter_to_do_app/2_application/pages/settings/settings_page.dart';
import 'package:go_router/go_router.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
 const String _basePath = '/start';
final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [GoRouterObserver()],
  initialLocation: '$_basePath/${DashboardPage.pageConfig.name}',
  routes: [
    GoRoute(
      name: SettingsPage.pageConfig.name,
      path: '$_basePath/${SettingsPage.pageConfig.name}',
      builder: (context, state) {
         return SettingsPage();
        // Container(
        //   color: Colors.amber,
        //   child: Column(
        //     children: [
        //       ElevatedButton(onPressed: (){
        //         context.push('/home/start');
        //       }, child: Text("Go to start")),
        //       TextButton(onPressed: (){
        //         if(context.canPop()){
        //            context.pop();
        //         }else{
        //           context.push('/home/start');
        //         }
               
        //       }, child: Text("Go Back"))
        //     ],
        //   ),
        //   );
      },
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: '$_basePath/:tab',
          builder:(context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab'] ?? 'dashboard'
          ),

          )
      ]),
    //  GoRoute(
    //   path: '/home',
    //   builder: (context, state) {
    //     return HomePage();
    //     // Container(color: Colors.blue,
    //     // child: Column(
    //     //     children: [
    //     //       ElevatedButton(onPressed: (){
    //     //         context.push('/home/settings');
    //     //       }, child: Text("Go to settings")),
    //     //       TextButton(onPressed: (){
    //     //          if(context.canPop()){
    //     //            context.pop();
    //     //         }else{
    //     //           context.push('/home/settings');
    //     //         }
    //     //       }, child: Text("Go Back"))
    //     //     ],
    //     //   ),
    //     // );
    //   },
    // ),
  ],
);
