import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'login.dart';
import '../db/users.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  //IMPORT FROM USERS FILE
  UserServices _userServices = UserServices();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _numberTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  String gender;
  String groupValue = "male";
  bool loading = false;
  bool hidePassword = true;
//VARIABLES FOR NUMBERS
  String sendNumber;
  String verifyCode;
  String receiveCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/logo.png",
              fit: BoxFit.contain,
              height: 50.0,
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            alignment: Alignment.center,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //==== FOR NAME ====

                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _nameTextController,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              icon: Icon(Icons.person_outline),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The name field cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    //== END NAME ==

                    //==== FOR NAME ====

                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _numberTextController,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              icon: Icon(Icons.phone),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The phone number field cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    //== END NAME ==

                    // == EMAIL ==
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _emailTextController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              icon: Icon(Icons.email),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please, make sure your email address is valid';
                                else
                                  return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    //== END EMAIL

                    //==== FOR PASSWORD ====
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _passwordTextController,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                hintText: "Password *",
                                icon: Icon(Icons.lock_outline),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The password field cannot be empty";
                                } else if (value.length < 6) {
                                  return "Your password must be at least 6 character long";
                                }
                                return null;
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  hidePassword = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    //== END PASSWORD ==

                    //==== FOR CONFIRM PASSWORD ====

                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _confirmPasswordTextController,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                hintText: "Confirm password",
                                icon: Icon(Icons.lock_outline),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The password field cannot be empty";
                                } else if (value.length < 6) {
                                  return "Your password must be at least 6 character long";
                                } else if (_passwordTextController.text !=
                                    value) {
                                  return "Your password must be same as above inputted password";
                                }
                                return null;
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    //== END CONFIRM PASSWORD ==

                    //GENDER
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                      child: Container(
                        color: Colors.white.withOpacity(0.5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "male",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Radio(
                                    value: "male",
                                    groupValue: groupValue,
                                    onChanged: (e) => valueChanged(e)),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "female",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Radio(
                                    value: "female",
                                    groupValue: groupValue,
                                    onChanged: (e) => valueChanged(e)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //==== FOR BUTTON ====

                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.pink.withOpacity(0.9),
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () async {
                            //
                            validateForm();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //== END BUTTON ==

                    // SIGN UP BUTTON
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text("Login",
                              style: TextStyle(color: Colors.red))),
                    ),
                    //END SIGN UP BUTTON

                    Divider(
                      color: Colors.white,
                    ),

                    //==== FOR Sign in with google ====

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.redAccent.withOpacity(0.9),
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () {
                            handleSignIn();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'images/google.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                              Text(
                                "Sign in with google instead",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //== END Sign in with google ==
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.9),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //METHODS
  void handleSignIn() {}

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;
    // Map value;
    if (formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) => {
                  _userServices.createUser(
                    {
                      "username": _nameTextController,
                      "email": _emailTextController,
                      "userId": user.uid,
                      "gender": gender,
                      "phoneNumber": _numberTextController,
                    },
                  )
                })
            .catchError((err) => {print(err.toString())});
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
