import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/consts/theme_data.dart';
import 'package:news_app/providers/theme_providerl.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// need it to access the theme Provider.

  ThemeProvider changeThmeProvider = ThemeProvider();
  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //Fetch the current theme.
  void getCurrentAppTheme() async {
    changeThmeProvider.setDarkTheme =
        await changeThmeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return changeThmeProvider;
        }),
      ],
      child:
          //Notify about theme changes
          Consumer<ThemeProvider>(builder: (context, thmeChangeProvider, ch) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog',
            theme: Styles.themeData(changeThmeProvider.getDarkTheme, context),
            home: HomeScreen());
      }),
    );
  }
}
