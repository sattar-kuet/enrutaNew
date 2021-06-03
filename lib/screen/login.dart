import 'dart:convert';

import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/loginController/loginController.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/screen/homePage.dart';
import 'package:enruta/screen/resetpassword/resetPassword.dart';

import 'package:enruta/screen/signup.dart';
import 'package:enruta/widgetview/custom_btn.dart';

import 'package:flutter/material.dart';
import 'package:enruta/Animation/FadeAnimation.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
// ignore: unused_import
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:enruta/helper/FacebookLogin.dart';
import 'package:http/http.dart' as http;

// class LoginPage extends GetWidget<LoginController> {
// class LoginPage extends StatelessWidget {

GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
// GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );
// GoogleSignIn googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  final LoginController lController = Get.put(LoginController());
  final heroTag = "assets/images/homeimage.png";
  bool _isHidden = true;
  GoogleSignInAccount currentUser;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String name = '', image;
  // ignore: unused_field
  String _message = 'Log in/out by pressing the buttons below.';

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = '';

  void checkloginstutas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    // ignore: unused_local_variable
    int islogin = prefs.getInt('islogin');

    if (email == null) {
      print(email);
    } else {
      await Geolocator().getCurrentPosition();
      var permission = await Geolocator().checkGeolocationPermissionStatus();
      if (permission != GeolocationStatus.denied) {
        Get.offAll(HomePage());
      } else {
        Get.defaultDialog(title: "Please give Permission first");
      }
      //Get.offAll(HomePage());
    }
  }

  // ignore: unused_field
  GoogleSignInAccount _currentUser;
  // ignore: unused_field
  String _contactText = '';

  @override
  void initState() {
    super.initState();

    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     _handleGetContact(_currentUser);
    //   }
    // });
    // _googleSignIn.signInSilently();

    //
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
        if (currentUser != null) {
          setcurentgoogleUser();
          print(currentUser.photoUrl);
        }
      });
    });
    // googleSignIn.signInSilently();
  }

  // ignore: unused_element
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  void setcurentgoogleUser() async {
    SharedPreferences shp = await SharedPreferences.getInstance();

    // int uid = int.parse(currentUser.id) ;
    // shp.setInt("id", uid);
    shp.setString("name", currentUser.displayName);
    shp.setString("email", currentUser.email);
    shp.setString("profileImage", currentUser.photoUrl);
    shp.setString("checkLogin", "a");
    // lController.pimage.value = currentUser.photoUrl;
    lController.googleuser(currentUser.email, currentUser.displayName);
    print(currentUser.photoUrl);
    print(currentUser.id);
    print(currentUser);
    // Get.offAll(HomePage());
  }

  bool rememberme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height - 2.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              matchTextDirection: false,
              image: AssetImage("assets/images/homeimage.png"),
              fit: BoxFit.none,
            ),
          ),
        ),
        Positioned(
            top: 230.0,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    color: Colors.white),
                height: MediaQuery.of(context).size.height - 100.0,
                width: MediaQuery.of(context).size.width)),
        Positioned(
          top: 120.0,
          left: (MediaQuery.of(context).size.width / 2) - 150,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      text('welcome'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    Text(
                      text('please_log_into_your_account'),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 250.0,
          left: 25.0,
          right: 25.0,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.3,
                          buidTextfield3(
                              text('email'), emailController, context)),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          1.3,
                          buidTextfield3(
                              text('password'), passwordController, context)),
                    ],
                  )),
              SizedBox(
                height: 1,
              ),
              Container(
                height: 50,
                alignment: Alignment.topLeft,
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                          left: -9,
                          child: Obx(() => IconButton(
                                icon: lController.flag.value
                                    ? Icon(
                                        Icons.check_box_rounded,
                                        color: theamColor,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank_outlined,
                                        color: theamColor,
                                      ),
                                onPressed: () {
                                  lController.flag.toggle();
                                },
                              ))

                          //  Checkbox(
                          //   activeColor: Color(Helper.getHexToInt("#11CBA1")),
                          //   onChanged: (bool rest) {
                          //     setState(() {
                          //       rememberme = rest;
                          //     });
                          //   },
                          //   value: rememberme,
                          // ),
                          ),
                      Positioned(
                        left: 35,
                        top: 15,
                        child: Text(
                          text('remember_me'),
                          style: TextStyle(
                              color: Color(Helper.getHexToInt("#6F6F6F"))),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 15,
                        child: InkWell(
                          onTap: () {
                            Get.to(ResetPassword());
                          },
                          child: Text(
                            text('forgot_password'),
                            style: TextStyle(
                                color: Color(Helper.getHexToInt("#6F6F6F"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                  1.6,
                  CustomButton(
                    loadingenabled: true,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [
                              Color(Helper.getHexToInt("#11CAA1")),
                              Color(Helper.getHexToInt("#11E3A1"))
                            ]),
                      ),
                      child: Center(
                        child: Text(
                          text('login'),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onclick: () async {
                      print("Container clicked");
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));

                      if (_formkey.currentState.validate()) {
                        var email = emailController.text;
                        var password = passwordController.text;
                        if (email.isEmpty) {
                          Get.snackbar(text('please_enter_valid_email'), "",
                              snackPosition: SnackPosition.BOTTOM);
                          return;
                        }
                        if (password.isEmpty) {
                          Get.snackbar(text('please_enter_valid_password'), "",
                              snackPosition: SnackPosition.BOTTOM);
                          return;
                        }

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });

                        print(email + "" + password);

                        lController.login(email, password);

                        Navigator.pop(context);
                        // }
                      }

                      print("Container was tapped");
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.7,
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: <Widget>[
                        Text(
                          text('don_t_have_an_account_yet'),
                          style: TextStyle(
                              color: Color(Helper.getHexToInt("#6F6F6F"))),
                        ),
                        GestureDetector(
                            onTap: () {
                              print("Container clicked");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp(
                                            heroTag: "assets/group4320.png",
                                          )));
                            },
                            child: new Container(
                              child: Text(
                                text('register'),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Color(Helper.getHexToInt("#11C4A1"))),
                              ),
                            )),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.7,
                GestureDetector(
                    onTap: () {
                      // print("Container clicked");
                      // Get.to(TestPage());
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => HomePaget()));
                    },
                    child: new Container(
                      child: Text(
                        text('or_login_with'),
                        style: TextStyle(
                            color: Color(Helper.getHexToInt("#6F6F6F"))),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FadeAnimation(
                        1.9,
                        CustomButton(
                          loadingenabled: true,
                          btncolor: Colors.blue,
                          onclick: () {
                            print("facebook");

                            faceBookLogin();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(Helper.getHexToInt("#4267B2"))),
                            child: Center(
                              child: Text(
                                "Facebook",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: FadeAnimation(
                        2,
                        CustomButton(
                          loadingenabled: true,
                          btncolor: Colors.red,
                          onclick: () {
                            print("google");
                            _handleSignIn();
                            // lController.handleSignIn();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(Helper.getHexToInt("#EB4132"))),
                            child: Center(
                              child: Text(
                                "Google",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 80,
        ),
      ])
    ]));
  }

  Widget buidTextfield3(String hintText, TextEditingController scontroller,
      BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 55,
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 2),

            child: TextField(
              // keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    TextStyle(color: Color(Helper.getHexToInt("#6F6F6F"))),
                // border: InputBorder.none,
                border: OutlineInputBorder(
                  gapPadding: 5,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: hintText == text('email')
                    ? Icon(Icons.email)
                    : hintText == text('password')
                        ? Icon(Icons.lock)
                        : null,
                suffixIcon: hintText == text('password')
                    ? IconButton(
                        // onPressed: () {
                        //   // lController.pflag.toggle();

                        // },
                        onPressed: _toggleVisibility,
                        icon: _isHidden
                            ? Icon(
                                Icons.visibility_off,
                                color: theamColor,
                              )
                            : Icon(
                                Icons.visibility,
                                color: theamColor,
                              ),
                      )
                    : null,
              ),
              controller: scontroller,
              obscureText: hintText == text('password') ? _isHidden : false,
            ),
          )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      print("login");
      handleSignOut();
      //await googleSignIn.signIn();
      if (currentUser != null) {
        handleSignOut();
      }
      if (lController.currentUser != null) {
        handleSignOut();
      }
      await Geolocator().getCurrentPosition();
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // LoginManager.getInstance().logInWithReadPermissions(this, Arrays.asList("public_profile"));

  Future<Null> faceBookLogin() async {
    await Geolocator().getCurrentPosition();
    facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // final result = await facebookSignIn.logInWithReadPermissions(['email']);
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    // await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=first_name,picture&access_token=${accessToken.token}');
        final profile = jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          name = profile['first_name'];
          image = profile['picture']['data']['url'];
        });

        SharedPreferences shp = await SharedPreferences.getInstance();
        var id = profile['id'];

        // int uid = int.parse(currentUser.id) ;
        shp.setInt("id", int.parse(id));
        shp.setString("name", name);
        shp.setString("email", profile['id']);
        shp.setString("profileImage", image);
        shp.setInt("islogin", 1);
        shp.setString("checkLogin", "a");
        lController.facebookUser(id, name);
        // lController.pimage.value = currentUser.photoUrl;
        print(name);

        print(image);

        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  // ignore: unused_element
  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> handleSignOut() async {
    googleSignIn.disconnect();
  }
}

// e7:61:78:2b:d5:fb:90:90:03:8a:43:61:35:3d:e8:88:59:8e:ef:54
// E7:61:78:2B:D5:FB:90:90:03:8A:43:61:35:3D:E8:88:59:8E:EF:54

// FA:A5:74:2E:92:DD:FB:D4:97:75:C1:F7:D1:DD:44:14:4E:09:36:82

// SHA-256: 1F:B0:AD:25:A9:82:51:BF:B8:78:D1:9D:D7:82:4A:EB:75:B5:DC:C7:BA:FF:A1:64:1E:BD:32:89:76:F2:06:C7
