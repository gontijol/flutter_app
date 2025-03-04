import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/routes/app_routes.dart';
import 'package:namer_app/second_page/controller.dart';
import 'package:namer_app/second_page/second_page.dart';

class AppPages {
  late final router = GoRouter(initialLocation: AppRoutes.home, routes: [
    GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => MyHomePage(),
        routes: [
          GoRoute(
            path: AppRoutes.second,
            name: AppRoutes.second,
            builder: (context, state) {
              Get.lazyPut(() => ItemController());
              return SecondPage();
            },
          )
        ])
  ]);
}
