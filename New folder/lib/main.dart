import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

// import 'package:navigation_drawer_example/widget/button_widget.dart';
// import 'package:navigation_drawer_example/widget/navigation_drawer_widget.dart';

import 'Blooms_taxonomy_Screen.dart';

import 'SharedPrefrencesFiles/isLogedIn.dart';
import 'Widget/ButtonWidget.dart';
import 'Widget/NavigationDrawerWidget.dart';
import 'Widget/error.dart';
import 'Widget/loaderWidget.dart';
import 'start_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: loggedInSharedPrefrence().getlogin(),
      builder: (context, snapshot) {
        // If your data is not loading show loader
        if (!snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Career vault',
            theme: ThemeData.light(),
            home: LoaderWidget(),
          );
          // If your data is not loading show loader
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Career vault',
            theme: ThemeData.light(),
            home: ErrorPage(
              message: "Loading failed",
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Career vault',
          theme: ThemeData.light(),

          // home: snapshot.data == true ? StartScreen() : VersionScreen()
          home: StartScreen(),
        );
      },
    );
  }
}
