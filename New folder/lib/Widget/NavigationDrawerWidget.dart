import 'package:flutter/material.dart';
import 'package:trivia_app/SharedPrefrencesFiles/UserIdSharedPrefs.dart';
import 'package:trivia_app/SharedPrefrencesFiles/VersionSharedPrefs.dart';
import 'package:trivia_app/SharedPrefrencesFiles/emailPrefs.dart';
import 'package:trivia_app/SharedPrefrencesFiles/isLogedIn.dart';
import 'package:trivia_app/Version_Selection.dart';

import 'package:trivia_app/Widget/SubscriptionPage.dart';
import 'package:trivia_app/Widget/loaderWidget.dart';

// import 'package:navigation_drawer_example/page/favourites_page.dart';
// import 'package:navigation_drawer_example/page/people_page.dart';
// import 'package:navigation_drawer_example/page/user_page.dart';

import '../SharedPrefrencesFiles/HighScore.dart';
import '../SharedPrefrencesFiles/TokenSharedPrefs.dart';
import '../SharedPrefrencesFiles/UserNameprefs.dart';
import '../start_screen.dart';
import 'Highest_score.dart';
import 'UserPage.dart';
import 'error.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key, required this.name})
      : super(key: key);
  final String name;
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationDrawerWidget> {
  late bool processing = false;
  late double score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processing = false;

    Future sc = ScorePrefrence().getScore();
    sc.then((data) async {
      score = data;
    });
  }

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final urlImage = "https://cdn-icons-png.flaticon.com/512/149/149071.png";
    return FutureBuilder<String>(
        future: emailPrefrence().getemail(),
        builder: (context, snapshot) {
          // If your data is not loading show loader
          if (!snapshot.hasData) {
            return LoaderWidget();
            // If your data is not loading show loader
          } else if (snapshot.hasError) {
            return ErrorPage(
              message: "Loading failed",
            );
          }
          return Drawer(
            child: Material(
              color: Color.fromARGB(255, 32, 142, 245),
              //const Color.fromRGBO(50, 75, 205, 1),
              child: ListView(
                children: <Widget>[
                  buildHeader(
                    urlImage: urlImage,
                    name: snapshot.data.toString().split('@')[0],
                    email: snapshot.data.toString(),
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                        name: snapshot.data.toString().split('@')[0],
                        urlImage: urlImage,
                      ),
                    )),
                  ),
                  Container(
                    padding: padding,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        buildSearchField(),
                        const SizedBox(height: 24),
                        buildMenuItem(
                          text: 'Packages',
                          icon: const IconData(0xe618,
                              fontFamily: 'MaterialIcons'),
                          onClicked: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SubscriptionPage(),
                          )),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Highest Score',
                          icon: const IconData(0xef90,
                              fontFamily: 'MaterialIcons'),
                          onClicked: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CustomDialogBox(
                                      descriptions: 'Your Top Score is ' +
                                          score.toString() +
                                          "%",
                                      img: Image.asset("userProfile.jpg"),
                                      text: 'Ok',
                                      title: 'Highest Score',
                                    )))
                          },
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Logout',
                          icon: const IconData(0xe3b3,
                              fontFamily: 'MaterialIcons'),
                          onClicked: () => {
                            logout(),
                            processing
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoaderWidget()))
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StartScreen()))
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => PeoplePage(),
        // ));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FavouritesPage(),
        // ));
        break;
    }
  }

  logout() {
    setState(() {
      processing = true;
    });

    VersionSharedPrefrence().removeVersion();
    loggedInSharedPrefrence().removelogin();
    SharedPrefrence2().removeId();
    SharedPrefrence().deleteToken();
    ScorePrefrence().deleteScore();
    emailPrefrence().deleteemail();
    userNamePrefrence().deleteName();

    setState(() {
      processing = false;
    });
  }
}
