import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:logintest/home/userscreen.dart';
import 'package:logintest/login/mainlogo.dart';
import 'package:logintest/login/signin.dart';
import 'package:logintest/login/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isLoading = false;
  bool _isLogin = false;

  _checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLogin = preferences.get('isLogin') ?? false;

    setState(() {
      _isLogin = isLogin;
    });
  }

  _updateLoadingStatus(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return UserScreen();
    return _isLogin ? UserScreen() : Scaffold(
      //resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/intro_bg.png'),
                fit: BoxFit.fill
              )
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    mainLogo(),
                    Flexible(
                      child: SignIn(_updateLoadingStatus),
                      fit: FlexFit.loose,
                    ),
                    Flexible(child: SignUp(_updateLoadingStatus), fit: FlexFit.loose,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: !_isLoading ? Container() : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              color: Colors.white.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
