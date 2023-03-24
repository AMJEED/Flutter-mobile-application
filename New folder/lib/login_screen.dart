import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:trivia_app/JobSeclectionScreen.dart';
import 'package:http/http.dart' as http;
import 'package:trivia_app/SharedPrefrencesFiles/UserNameprefs.dart';
import 'package:trivia_app/SharedPrefrencesFiles/VersionSharedPrefs.dart';
import 'package:trivia_app/SharedPrefrencesFiles/emailPrefs.dart';
import 'dart:developer';

import 'SharedPrefrencesFiles/TokenSharedPrefs.dart';
import 'SharedPrefrencesFiles/UserIdSharedPrefs.dart' as pref2;
import 'SharedPrefrencesFiles/UserIdSharedPrefs.dart';
import 'SharedPrefrencesFiles/isLogedIn.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QuestionAmountSelection.dart';
import 'start_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  late String SigninError;
  late bool processing;
  late String token;
  late String userId;

  bool _submit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return false;
    } else {
      signIn(emailcontroller.text, passwordcontroller.text);
      _formKey.currentState!.save();

      return true;
    }
  }

  @override
  void initState() {
    SigninError = "";
    processing = false;
    token = "";
    userId = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/circles.png",
                  height: 130,
                  width: 150,
                ),
              ),
              const Center(
                child: Text(
                  "\n Welcome Back",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/Login.png",
                  height: 200,
                  width: 200,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (value != null) {
                            var v = EmailValidator.validate(value);
                            if (!v) {
                              return "Please enter valid email";
                            }
                          }

                          return null;
                        },
                        // controller: UsernameController,
                        maxLines: null,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 238, 234, 234)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 99, 98, 98)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 234, 234),
                            labelText: "Enter your Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            hintText: "Enter your Email"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        obscureText: true,

                        controller: passwordcontroller,
                        // controller: UsernameController,
                        maxLines: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 238, 234, 234)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 99, 98, 98)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 234, 234),
                            labelText: "Enter password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            hintText: "Enter password"),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              TextButton(
                  onPressed: () async {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: ((context) => JobSelecionScreen()),
                    //       ));
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(color: Colors.blue),
                  )),
              processing
                  ? CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: ((context) => JobSelecionScreen()),
                        //     ));
                        _submit();
                        if (SigninError == "User doesnot Exists...") {
                          Text("Invalid Credentials",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 247, 2, 2),
                                  fontWeight: FontWeight.bold));
                        }
                      },
                      child: Container(
                        color: Color.fromARGB(255, 32, 142, 245),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 100),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              SigninError.length > 1
                  ? Text("Invalid Credentials",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 247, 2, 2),
                          fontWeight: FontWeight.bold))
                  : SizedBox(
                      height: 10.0,
                    ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => SignUpScreen()),
                      ));
                },
                child: const Text.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: "Don't have any Account? ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: " Sign Up", style: TextStyle(color: Colors.blue)),
                  ],
                )),
              ),
            ],
          ),
        ));
  }

  signIn(email, password) async {
    setState(() {
      processing = true;
    });
    var url = "https://fyp-demo.herokuapp.com/api/applicants/signIn";

    // var url = "http://localhost:8080/api/applicants/signIn"; // iOS
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    if (response != null) {
      debugPrint(response.body.toString());
      if ((json.decode(response.body)["message"] != null)) {
        if (json.decode(response.body)["message"].toString() ==
                "User doesnot Exists..." ||
            json.decode(response.body)["message"].toString() ==
                "Invalid Credentails") {
          debugPrint(json.decode(response.body).toString());

          setState(() {
            SigninError = json.decode(response.body)["message"].toString();
          });
        }
      } else if (json.decode(response.body)["result"] != null) {
        setState(() {
          userId = json.decode(response.body)["result"]["id"].toString();
          token = json.decode(response.body)["token"];
        });
        json.decode(response.body)["result"]["versionUsing"].toString() ==
                "PAID"
            ? VersionSharedPrefrence().setVersion(true)
            : VersionSharedPrefrence().setVersion(false);
        emailPrefrence().setemail(email);

        SharedPrefrence().setToken(token);
        SharedPrefrence2().setId(userId);
        loggedInSharedPrefrence().setlogin(true);
        debugPrint("Token added and id added");
        getUserInfo(userId, token);

        debugPrint(json.decode(response.body).toString());

        debugPrint("Successfully LogedIn");

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => JobSelecionScreen()),
            ));
      }
    } else {
      throw Exception('Failed to create album.');
    }

    setState(() {
      processing = false;
    });
  }

  getUserInfo(id, token) async {
    // var url = "http://localhost:8080/api/applicants/" + id;
    ; // iOS
    var url = "https://fyp-demo.herokuapp.com/api/applicants/" + id;
    // var url = "http://localhost:8080/api/applicants/" + id; // iOS
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "auth": token
      },
    );
    if (response.body != null) {
      if (response.body.toString == "Unauthenticated") {
        debugPrint("User not authenticated");
      } else if (json.decode(response.body)["message"].toString() ==
          "JsonWebTokenError") {
        debugPrint("Token error");
      } else if (json.decode(response.body)["user"] != null) {
        var e = json.decode(response.body)["user"]["email"];
        var n = json.decode(response.body)["user"]["name"];

        emailPrefrence().setemail(e);
        userNamePrefrence().setName(n);
        debugPrint(" " + e + "" + n);
      }
    }

    debugPrint(response.body.toString());
  }
}
