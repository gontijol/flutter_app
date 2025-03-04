import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/core/ui/app_theme.dart';
import 'package:namer_app/routes/app_pages.dart';
import 'package:namer_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppPages().router,
        title: 'Namer App',
        theme: appTheme,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                child: InkWell(
                  onTap: () => context.goNamed(AppRoutes.second),
                  child: Card(
                    color: Colors.blue.withAlpha(100),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(appState.current.asPascalCase),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
