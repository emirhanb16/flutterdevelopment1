import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/services/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import '../../core/localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AutomaticKeepAliveClientMixin<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late CartCubit cartCubit;
  late ClientCubit clientCubit;
  late ProductsCubit productsCubit;

  bool loading = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context).getTranslate("select-language")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: clientCubit.state.language != "en"
                    ? () {
                        clientCubit.changeLanguage("en");
                      }
                    : null,
                child: Text("English"),
              ),
              ElevatedButton(
                onPressed: clientCubit.state.language != "tr"
                    ? () {
                        clientCubit.changeLanguage("tr");
                      }
                    : null,
                child: Text("Türkçe"),
              ),
              ElevatedButton(
                onPressed: clientCubit.state.language != "pl"
                    ? () {
                        clientCubit.changeLanguage("pl");
                      }
                    : null,
                child: Text("Polski"),
              ),
            ],
          ),
        );
      },
    );
  }

  login() async {
    setState(() {
      loading = true;
      errorMessage = "";
    });

    API api = API();

    try {
      final response = await api.login(
        username: emailController.text,
        password: passwordController.text,
      );

      if (response is Exception) {
        setState(() {
          errorMessage =
              AppLocalizations.of(context).getTranslate("invalid-email");
        });
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String registeredEmail = prefs.getString('email') ?? "";
        String registeredPassword = prefs.getString('password') ?? "";

        if (emailController.text == registeredEmail &&
            passwordController.text == registeredPassword) {
          GoRouter.of(context).push("/home");
        } else {
          setState(() {
            errorMessage = AppLocalizations.of(context).getTranslate("invalid");
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).getTranslate("login")),
          actions: [
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                showLanguageDialog(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: "),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(49, 158, 158, 158),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .getTranslate("enter-email")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)
                              .getTranslate("enter-email");
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(AppLocalizations.of(context).getTranslate("password")),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(49, 158, 158, 158),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .getTranslate("enter-password")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)
                              .getTranslate("enter-password");
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            login();
                          }
                        },
                        child: Text(
                            AppLocalizations.of(context).getTranslate("login")),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push("/register");
                        },
                        child: Text(AppLocalizations.of(context)
                            .getTranslate("register")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
