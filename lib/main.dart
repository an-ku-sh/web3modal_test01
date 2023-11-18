import 'package:flutter/material.dart';
import './home_page.dart';
import './/utils/string_constants.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isDarkMode = false;
  Web3ModalThemeData? _themeData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        final platformDispatcher = View.of(context).platformDispatcher;
        final platformBrightness = platformDispatcher.platformBrightness;
        _isDarkMode = platformBrightness == Brightness.dark;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        final platformDispatcher = View.of(context).platformDispatcher;
        final platformBrightness = platformDispatcher.platformBrightness;
        _isDarkMode = platformBrightness == Brightness.dark;
      });
    }
    super.didChangePlatformBrightness();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Web3ModalTheme(
      isDarkMode: _isDarkMode,
      themeData: _themeData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstants.w3mPageTitleV3,
        home: MyHomePage(
          swapTheme: () => _swapTheme(),
          changeTheme: () => _changeTheme(),
        ),
      ),
    );
  }

  void _swapTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeTheme() {
    setState(() {
      _themeData = (_themeData == null)
          ? Web3ModalThemeData(
              lightColors: Web3ModalColors.lightMode.copyWith(
                accent100: Colors.red,
                background125: Colors.yellow.shade300,
              ),
              darkColors: Web3ModalColors.darkMode.copyWith(
                accent100: Colors.green,
                background125: Colors.brown,
              ),
              radiuses: Web3ModalRadiuses.square,
            )
          : null;
    });
  }
}
