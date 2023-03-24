import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key,
      required this.pkgText,
      required this.pkgPrice,
      required this.pkgduration,
      required this.color})
      : super(key: key);
  final String pkgText;
  final String pkgPrice;
  final String pkgduration;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 400,
            height: 300,
            padding: new EdgeInsets.all(20.0),
            margin: EdgeInsets.all(20.0),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFF4F4FFD),
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        "assets/images//rank.png",
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        pkgText,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    ListTile(
                        subtitle: Text("Price:" + pkgPrice,
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    ListTile(
                      subtitle: Text("Duration:" + pkgduration,
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                    ),
                    ListTile(
                      subtitle: ButtonBar(
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const LoginScreen(),
                              //   ),
                              // );
                            },
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 120),
                              child: const Text(
                                'Buy',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 12, 12, 12),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

Widget buildSearchField() {
  final color = Colors.white;

  return TextField(
    style: TextStyle(color: color),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
