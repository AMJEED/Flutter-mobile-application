import 'dart:convert';

import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  @override
  _ForgotPasswordstate createState() => _ForgotPasswordstate();
}

class _ForgotPasswordstate extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final OtpController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();

  late EmailAuth emailAuth;
  late bool otpValid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "Password reset",
    );
    otpValid = false;

// remoteServerConfiguration : Signature
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final password1 = passwordController.text;
    final password2 = repeatpasswordController.text;
    final email = emailController.text;

    _formKey.currentState!.save();
  }

  senOtp() async {
    EmailAuth(sessionName: 'Password Reset');
    bool result = await emailAuth.sendOtp(
        recipientMail: emailController.value.text, otpLength: 5);

    if (result) {
      setState(() {
        otpValid = true;
      });
    }
  }

  void verify() {
    print(emailAuth.validateOtp(
        recipientMail: emailController.value.text,
        userOtp: OtpController.value.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "circles.png",
                  height: 150,
                  width: 200,
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
              Center(
                child: Image.asset(
                  "Login.png",
                  height: 400,
                  width: 400,
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      SizedBox(
                        width: 360,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value != null) {
                              var v = EmailValidator.validate(value);
                              if (!v) {
                                return "Enter your email";
                              }
                            }

                            return null;
                          },
                          maxLines: null,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
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
                      otpValid
                          ? SizedBox(
                              width: 360,
                              child: TextFormField(
                                validator: (PassCurrentValue) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  var passNonNullValue = PassCurrentValue ?? "";
                                  if (passNonNullValue.isEmpty) {
                                    return ("Password is required");
                                  } else if (passNonNullValue.length < 6) {
                                    return ("Password Must be more than 5 characters");
                                  } else if (!regex
                                      .hasMatch(passNonNullValue)) {
                                    return ("Password should contain upper,lower,digit and Special character ");
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                maxLines: null,
                                decoration: InputDecoration(
                                    labelText: "Enter password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    hintText: "Enter password"),
                              ),
                            )
                          : SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      otpValid
                          ? SizedBox(
                              width: 360,
                              child: TextFormField(
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
                                maxLines: null,
                                decoration: InputDecoration(
                                    labelText: "Confirm password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    hintText: "Confirm password"),
                              ),
                            )
                          : SizedBox(height: 10),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              TextButton(
                onPressed: () {
                  _submit();
                  senOtp();
                },
                child: Container(
                  color: Color(0xFF4F4FFD),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 160),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
