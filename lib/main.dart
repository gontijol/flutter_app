import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/core/ui/app_theme.dart';
import 'package:namer_app/core/ui/colors.dart';
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
  var _current = WordPair.random();
  bool _isExpanded = false;

  WordPair get current => _current;
  bool get isExpanded => _isExpanded;

  void generateNewWordPair() {
    _current = WordPair.random();
    notifyListeners();
  }

  void toggleCardSize() {
    _isExpanded = !_isExpanded;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400), () {
      _isExpanded = !_isExpanded;

      notifyListeners();
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<MyAppState>(
              builder: (context, appState, child) {
                var sizeCardWidth = appState.isExpanded
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width * 0.3;
                var sizeCardHeight = appState.isExpanded
                    ? MediaQuery.of(context).size.height * 0.5
                    : MediaQuery.of(context).size.height * 0.3;

                var appColor = getRandomColor();

                return AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  height: sizeCardHeight,
                  width: sizeCardWidth,
                  child: InkWell(
                    onLongPress: () {
                      appState.generateNewWordPair();
                      appState.toggleCardSize();
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => context.goNamed(AppRoutes.second),
                    child: Card(
                      color: appColor,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          appState.current.asPascalCase,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
