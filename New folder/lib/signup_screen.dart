import 'dart:convert';

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
//Controllers for Form
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();

  //Other local variables
  late String SignupError;
  late bool processing;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SignupError = "";
    processing = false;
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      signup(
          nameController.text, emailController.text, passwordController.text);
    }

    _formKey.currentState!.save();
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
                  "\n Sign up",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Image.asset(
                  "assets/images/signUp.jpeg",
                  height: 180,
                  width: 280,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid username!';
                            }
                            return null;
                          },
                          maxLines: null,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 238, 234, 234)),
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
                              labelText: "Enter your full name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              hintText: "Enter your full name"),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value != null) {
                              var v = EmailValidator.validate(value);
                              if (!v) {
                                return "Please enter valid email";
                              }
                            }

                            return null;
                          },
                          maxLines: null,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 238, 234, 234)),
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
                                  Radius.circular(50),
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
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (PassCurrentValue) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            var passNonNullValue = PassCurrentValue ?? "";
                            if (passNonNullValue.isEmpty) {
                              return ("Password is required");
                            } else if (passNonNullValue.length < 6) {
                              return ("Password Must be more than 5 characters");
                            } else if (!regex.hasMatch(passNonNullValue)) {
                              return ("Password should contain upper,lower,digit and Special character ");
                            }
                            return null;
                          },
                          controller: passwordController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 238, 234, 234)),
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
                                  Radius.circular(50),
                                ),
                              ),
                              hintText: "Enter password"),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          obscureText: true,
                          controller: repeatpasswordController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Empty';
                            }
                            if (val != passwordController.text) {
                              return 'Not Match';
                            }
                            return null;
                          }
                          // controller: UsernameController,
                          ,
                          maxLines: 1,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 238, 234, 234)),
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
                              labelText: "Confirm password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              hintText: "Confirm password"),
                        ),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              processing
                  ? CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        _submit();
                      },
                      child: Container(
                        color: Color.fromARGB(255, 32, 142, 245),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 100),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              SignupError.length != 0
                  ? Text("Error raised : " + SignupError,
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
                        builder: ((context) => LoginScreen()),
                      ));
                },
                child: const Text.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: "Already have an account ? ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: " Log In", style: TextStyle(color: Colors.blue)),
                  ],
                )),
              ),
            ],
          ),
        ));
  }

  signup(username, email, password) async {
    setState(() {
      processing = true;
    });
    var url = "https://fyp-demo.herokuapp.com/api/applicants/signUp";
    // var url = "http://localhost:8080/api/applicants/signUp"; // iOS
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": username,
        "email": email,
        "password": password,
        "versionUsing": "Free"
      }),
    );

    if (response != null) {
      if (json.decode(response.body)["message"].toString() ==
          "User already Exists...") {
        debugPrint("USer Exist already");
        setState(() {
          SignupError = json.decode(response.body)["message"].toString();
        });
        setState(() {
          processing = false;
        });
        return;
      } else if (json.decode(response.body)["result"] != null) {
        debugPrint(json.decode(response.body).toString());

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => LoginScreen()),
            ));
      }
      //   // debugPrint(json.decode(response.body).toString());
      //   debugPrint("Successfully Registered");
      // }
      else {
        debugPrint(response.body.toString());
      }
    } else {
      throw Exception('Failed to create album.');
    }

    setState(() {
      processing = false;
    });
  }
}
