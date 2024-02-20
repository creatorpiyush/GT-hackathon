import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/home_page/main_page.dart';
import 'package:gt_hackathon/mock_data/mock_users.dart';

class UserState extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    return Future.delayed(loginTime).then((_) {
      _isLoading = false;
      notifyListeners();
      if (!mockUsers.containsKey(email)) {
        showCustomSnackbar(context, 'User not exists.');
        return 'User not exists';
      }
      if (mockUsers[email] != password) {
        _isLoading = false;
        notifyListeners();
        showCustomSnackbar(context, 'Password does not match.');
        return 'Password does not match';
      }
      print('Logged in successfully');
      prefs
          .setBool("isLogin", true)
          .then((_) => prefs.setString("username", email));
      Navigator.of(context).pushReplacement(
        FadePageRoute(
          builder: (context) => const MainPage(),
          settings: const RouteSettings(name: LoginPage.routeName),
        ),
      );
      return null;
    });
  }
}

class LoginPage extends StatefulWidget {
  static const routeName = '/auth';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset('assets/images/login_top.png'),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(230, 253, 255, 1),
                borderRadius: BorderRadius.circular(46.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 77, 115, 1),
                      fontSize: 36,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 36.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.info_rounded,
                            color: Color.fromRGBO(204, 204, 204, 1),
                            weight: 16.0,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "Please use your existing train ticketing account credentials to log in.",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            cursorColor: const Color.fromRGBO(183, 79, 111, 1),
                            decoration: const InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromRGBO(183, 79, 111, 1),
                                ))),
                            validator: (value) {
                              if (value!.isEmpty || !value.isValidEmail()) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: _passwordController,
                            cursorColor: const Color.fromRGBO(183, 79, 111, 1),
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromRGBO(183, 79, 111, 1),
                                ))),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          Consumer<UserState>(
                            builder: (context, userState, child) =>
                                ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(250, 50),
                                  backgroundColor:
                                      const Color.fromRGBO(240, 240, 240, 1),
                                  foregroundColor:
                                      const Color.fromRGBO(0, 0, 0, 1)),
                              onPressed: userState.isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        userState._loginUser(
                                            _emailController.text,
                                            _passwordController.text,
                                            context);
                                      }
                                    },
                              child: userState.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Login',
                                      style: TextStyle(fontSize: 18.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
                child: RichText(
                    text: const TextSpan(
                        text:
                            "If you don’t have an existing train ticketing account, ",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                      TextSpan(
                        text: 'register here',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromRGBO(183, 79, 111, 1),
                          fontSize: 16,
                        ),
                      )
                    ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    // Regular expression for a valid email address
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
    );

    return emailRegExp.hasMatch(this);
  }
}

void showCustomSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message,
        style: const TextStyle(
          fontSize: 16.0,
        )),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
